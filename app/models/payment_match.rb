class PaymentMatch < ApplicationRecord
      
      resourcify
      audited
  belongs_to :target_record, polymorphic: true,touch:true
  belongs_to :resource, polymorphic: true,touch:true
  belongs_to :billing_document_detail, -> {joins(:payment_match).where(payment_matches: {target_record_type: "BillingDocumentDetail"})},class_name: 'BillingDocumentDetail', foreign_key: 'target_record_id',optional: true, touch: true
  belongs_to :disbursement_request, -> {joins(:payment_match).where(payment_matches: {target_record_type: "DisbursementRequest"})},class_name: 'DisbursementRequest', foreign_key: 'target_record_id',optional: true, touch: true
  belongs_to :isa, -> {joins(:payment_match).where(payment_matches: {target_record_type: "Isa"})},class_name: 'Isa', foreign_key: 'target_record_id',optional: true
  belongs_to :payment,-> {joins(:payment_match).where(payment_matches: {resource_type: 'Payment'})},class_name: 'Payment',foreign_key: 'resource_id', optional: true

  after_create :refresh_disbursement

  validates :value, numericality: { greater_than: 0 }


  def refresh_disbursement
    if self.target_record_type == "DisbursementRequest"
      self.target_record.application.resource.touch
    end
  end

  def payment_value
  	self.payment.value
  end
end
