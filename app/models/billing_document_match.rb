class BillingDocumentMatch < ApplicationRecord
      
      resourcify
      audited


	belongs_to :resource, polymorphic: true,touch:true
  belongs_to :billing_document_detail
  belongs_to :billing_document, -> {joins(:billing_document_match).where(billing_document_matches: {resource_type: 'BillingDocument'})},class_name: 'BillingDocument', foreign_key: 'resource_id',optional: true
  has_many :payment_match, through: :billing_document_detail, source: :payment_match

  after_create :set_penalty

  def penalty_calculated_value value, days
    payment_config = self.resource.isa.funding_opportunity.payment_config
    daily_rate = (1 + payment_config.arrears_rate.to_d / 100)**(1/365.to_d) - 1
    factor = ((1 + daily_rate)**(days)*value - value).to_f.floor(1)
    return factor
  end


  def set_penalty
  	detail = self.billing_document_detail
    document = self.billing_document

    if detail.original_document.present?
      base_date = detail.original_document.due_to_date

      base_value = [detail.value - detail.payment_match.joins(:payment).where('payments.payment_date <= ? ',base_date).sum(:value),0].max
   	  if base_value > 0 && document.reference_date > detail.original_document.reference_date

        payment_config = self.resource.isa.funding_opportunity.payment_config
  	  	case payment_config.penalty_case
  	  	when 'arrears_rate'
          penalty_hash = {}
          penalty_value = 0
          detail.payment_match.joins(:payment).where('payments.payment_date > ? AND payments.payment_date < ?',base_date,document.reference_date).each do |match|
            days = (match.payment.payment_date - base_date).to_i
            penalty_value += [self.penalty_calculated_value(match.value, days),0].max
            base_value -= [match.value, base_value].min
          end
          days = (document.reference_date - base_date).to_i
  	  		penalty_value += self.penalty_calculated_value(base_value, days) - detail.penalties.where('reference_date < ?', document.reference_date).sum(:value)
          
  	  	when 'nominal_penalty'
  	  		penalty_value = payment_config.nominal_penalty
  	  	else
  	  		penalty_value = 0
        end
        penalty_value = penalty_value < 0 ? 0 : penalty_value
        
        if !self.migrated
    	  	billing_penalty = BillingDocumentDetail.find_by(billing_document_detail_id: detail.id,year: self.resource.year, month: self.resource.month,detail_case: 'penalty')
    	  	if billing_penalty.nil?
      			BillingDocumentDetail.create({billing_document_detail_id: detail.id ,isa_id: detail.isa_id, year: self.resource.year, month: self.resource.month, status: 'pending',payment_equivalency: 0, value: penalty_value,reference_date: "#{detail.year}-#{detail.month}-1".to_date,detail_case: 'penalty'}) unless penalty_value == 0
      		else
      			billing_penalty.update({status: 'pending',payment_equivalency: 0, value: penalty_value})
      		end
        end

    	end
    end

  end

end
