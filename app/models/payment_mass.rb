class PaymentMass < ApplicationRecord
      
      resourcify
      audited
  belongs_to :company

  has_one_attached :payments_file
  has_many :payment_mass_detail

  after_commit :start_generation, on: [:create, :update]
  after_commit :run_payments_creation, on: [:create, :update]
  after_touch :update_payment_status
  after_commit :discard_if_discarded

  def discard_if_discarded
    if self.discarded?
      detail_ids = self.payment_mass_detail.ids
      self.payment_mass_detail.update_all(discarded_at: self.discarded_at)
      PaymentMassDoc.where(payment_mass_detail_id: detail_ids).update_all(discarded_at: self.discarded_at)
    end
  end

  def run_payments_creation
    if self.status == 'process_payments'
      self.update(status: 'processing_payments')
      self.payment_mass_detail.pending_to_pay.each do |detail|
        if Rails.env == 'production'
          ModelClassesAsync.perform_async('PaymentMassDetail', 'generate_payment', detail.id)
        else
          detail.generate_payment
        end
      end

    end
  end

  def update_payment_status
    if self.status != 'payments_processed' && self.payment_mass_detail.pending_to_pay.count == 0
      self.update(status: 'payments_processed')
    end
  end

  def start_generation
  	if self.status == 'pending' && self.valid_file?
	  	self.update(status: 'processing')
      if Rails.env == 'production'
  	  	ModelClassesAsync.perform_async('PaymentMass', 'generate_details', self.id)
      else
        self.generate_details
      end
	  end
  end

  def get_records
    begin
      require 'csv'    
      csv_text = self.payments_file.download
      csv = CSV.parse(csv_text, :headers => true)
      csv.map{|r| r.to_h}
    rescue Exception => e
    end
  end

  def valid_file?
    if self.get_records.nil?
      @result = false
    else
    	records = self.get_records
    	@result = records.first.keys == ["No_de_cuenta_bancaria", "Referencia1", "Referencia2", "Valor", "Fecha", "Oficina", "Ciudad", "Descripcion"]
    end
    return @result
  end

  def details_without_identification_ids
    self.payment_mass_detail.where('id NOT IN (SELECT DISTINCT(payment_mass_detail_id) FROM payment_mass_docs)').where.not(origin_file_key: self.payments_file.key).or(
      self.payment_mass_detail.where('id NOT IN (SELECT DISTINCT(payment_mass_detail_id) FROM payment_mass_docs)').where(origin_file_key: nil)
      ).ids
  end

  def details_with_payments_ids
    self.payment_mass_detail.joins(payment_mass_doc: :payment).ids
  end

  def details_without_payment_ids
    self.payment_mass_detail.where.not(origin_file_key: self.payments_file.key,id: self.details_with_payments_ids).or(
      self.payment_mass_detail.where(origin_file_key: nil).where.not(id: self.details_with_payments_ids)
      ).ids.uniq
  end

  def dropable_details
    (self.details_without_identification_ids + self.details_without_payment_ids).uniq
  end

  def generate_details
  	if self.valid_file?
      dropable = self.dropable_details
      if dropable.count > 0
        PaymentMassDetail.where(id: self.dropable_details).destroy_all
      end
  		records = self.get_records
      records = records.select{|r| r.values.compact.size == 8}
  		records.each_with_index do |record,index|
  			detail = PaymentMassDetail.find_by(key: record.to_s, row: index)
  			if detail.nil?
  				detail = PaymentMassDetail.new(payment_mass_id: self.id,key: record.to_s,origin_file_key: self.payments_file.key,row: index)
  			end
  			record.keys.each do |key|
  				detail = translate_fields(key, record, detail)
  			end
  			if detail.save
          detail.get_billing_document_id
        end
  		end
  	end

    self.update(status: 'done')
  end

  def translate_fields key, record, detail

  	case key.to_s
  	when "No_de_cuenta_bancaria"
  		detail.bank_number = record[key]
  	when "Referencia1"
  		detail.ref_1 = record[key].force_encoding('iso8859-1').encode('utf-8')
  	when "Referencia2"
  		detail.ref_2 = record[key].force_encoding('iso8859-1').encode('utf-8')
  	when "Valor"
  		detail.value = record[key]
  	when "Fecha"
      fragment = record[key].to_s.split('/')
      if fragment.count > 2 && fragment.last.to_i > 1999 
        detail.transaction_date = DateTime.strptime(record[key], '%m/%d/%Y')
      else
  		  detail.transaction_date = record[key]
      end
  	when "Oficina"
  		detail.office = record[key].force_encoding('iso8859-1').encode('utf-8')
  	when "Ciudad"
  		detail.city = record[key].force_encoding('iso8859-1').encode('utf-8')
  	when "Descripcion"
  		detail.description = record[key].force_encoding('iso8859-1').encode('utf-8')
  	end
  	return detail
  end

end
