class BillingDocumentDetail < ApplicationRecord
      
  resourcify
  audited
  belongs_to :isa, touch: true
  belongs_to :payment_agreement, optional: true
  belongs_to :main_detail, class_name: 'BillingDocumentDetail', foreign_key: 'billing_document_detail_id',optional: true
  has_many :payment, through: :payment_match
  has_many :billing_document_match,->{kept}, dependent: :destroy
  has_many :billing_documents, through: :billing_document_match, source: :billing_document

  has_one :contact_info, as: :resource , dependent: :destroy


  has_many :payment_match,->{kept}, as: :target_record, dependent: :destroy
  has_many :penalties,class_name: 'BillingDocumentDetail',foreign_key: 'billing_document_detail_id', dependent: :destroy


  scope :pending_details_1, ->(year,month){joins(billing_document_match: :billing_document).where.not(status: ['payed','migrated']).where('billing_documents.reference_date = ?',("#{year}-#{month}-1".to_date - 1.month)).or(joins(billing_document_match: :billing_document).where.not(id: with_agreements_ids).where('billing_document_details.reference_date = ?',"#{year}-#{month}-1".to_date))}
  scope :pending_details_2, ->(year,month){where.not(id: with_agreements_ids).where('billing_document_details.reference_date = ?',"#{year}-#{month}-1".to_date)}

  before_save :update_applied_value
  before_save :set_equivalency_covered
  before_save :set_currency
  after_commit :set_reference_date, on: [:create, :update]
  after_commit :set_payment_status, on: [:create, :update]
  after_touch :billing_documents_touch, on: [:create, :update]
  after_commit :apply_payments_after_create, on: :create
  after_commit :check_payment_application



  def set_equivalency_covered
    self.equivalency_covered = self.value == 0 ? 0 : ((self.applied_value.to_f/self.value)* self.payment_equivalency)
  end

  def original_document
    self.isa.billing_document.find_by(reference_date: self.reference_date)
  end

  def self.pending_details year, month,legacy=false
    if legacy
      detail_ids = self.pending_details_1(year, month).ids 
    else
      detail_ids = self.pending_details_1(year, month).where('billing_documents.reference_date > ?','2020-03-01').ids 
    end
    detail_ids += self.pending_details_2(year, month).ids
    self.where(id: detail_ids.uniq)
  end


  def check_payment_application
    if self.value.to_f < self.applied_value.to_f
      self.payment_match.each do |match|
        match.payment.fix_overpayment self
        break if self.value == self.applied_value
      end
    elsif self.value > self.applied_value
      if self.user.payment_excess.sum(:value) > 0
        self.user.payment_excess.each do |excess|
          #The documents before migration still have a different structure (the document in arrears was duplicated)
          self.isa.billing_document.where('value > applied_value').where('reference_date >= ?  AND migrated = true','2020-04-01').or(self.isa.billing_document.where('value > applied_value').where('migrated = false OR migrated IS NULL')).each do |document|
            excess.payment.match_payments(billing_document_id: document.id)
          end
        end
      end
    end
  end

  def apply_payments_after_create
    payments_didnt_applied.each do |payment|
      payment.match_payments
    end
  end

  def payments_didnt_applied
    self.isa.payments.includes(:payment_match).where(payment_matches: { resource_id: nil }).where.not(resource_type: 'PaymentAgreement')
  end

  def user
    self.isa.user
  end

  def update_applied_value
      self.applied_value = self.applied_value_function
  end

  def billing_documents_touch
    self.save
    self.billing_documents.map(&:save)
  end

  def self.with_agreements_ids
    self.joins(payment_match: :payment).where(payment_matches: {payments: {resource_type: 'PaymentAgreement'}}).ids.uniq
  end


  def set_reference_date
  	if !self.year.nil? && !self.month.nil? && self.reference_date != "#{self.year}-#{self.month}-1".to_date
	  	self.update(reference_date: "#{self.year}-#{self.month}-1".to_date)
	  end
  end

############################

    # if self.pending_value <= 0 && self.status != 'payed'
    #   self.status = 'payed'
    # elsif self.applied_value.to_f > 0 && self.status != 'partial_payment'
    #   self.status = 'partial_payment'
    # elsif !self.due_to_date.nil? & self.pending_value != 0 && self.due_to_date < Time.now.to_date && self.status != 'arrears' && self.pending_value != 0
    #   self.status = 'arrears'
    # elsif self.applied_value.to_f == 0 && !self.due_to_date.nil? && self.due_to_date >= Time.now.to_date && self.payment.where.not(resource_type: "PaymentAgreement").sum(:value) == 0 
    #   self.status = 'pending'
    # end
############################


  def set_payment_status
    if self.status != 'payed' && self.applied_value >= self.value.to_f && self.value.to_f != 0
      self.update(status: 'payed')
    elsif self.status != 'partial_payment' && self.payment_match.sum(:value) > 0 && self.payment_match.sum(:value) < self.value.to_f
      self.update(status: 'partial_payment')
    elsif self.status != 'pending' && self.payment_match.sum(:value) == 0 && self.value != 0
      self.update(status: 'pending')
    end
  end

  def applied_value_function
    self.payment_match.sum(:value)
  end

  def penalties_applied_value
    self.penalties.map(&:applied_value).inject(:+).to_f
  end

  def penalty reference_date
    self.penalties.map{|p| p.value if p.reference_date <= reference_date}.compact.inject(:+).to_f
  end

  def pending_value
    self.value - self.applied_value.to_f
  end

  def pending_value_with_penalties
    self.value + self.penalty(self.reference_date) - self.applied_value_with_penalties
  end


  def applied_value_with_penalties_by_document document
    self.applied_value + self.penalties_applied_value
  end

  def applied_value_with_penalties
    self.payment_match.sum(:value) + BillingDocumentDetail.where(billing_document_detail_id: self.id).map{|detail| detail.applied_value}.sum
  end

  def value_with_penalties
    self.value + self.penalty
  end

  def set_currency
      self.currency = self.isa.currency
  end



end
