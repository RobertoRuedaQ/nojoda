class PaymentAgreement < ApplicationRecord
  include LumniFinance

  resourcify
  audited
  belongs_to :billing_document, touch: true, optional: true
  belongs_to :isa,touch: true
  has_one :payment, as: :resource , dependent: :destroy
  has_many :billing_document_detail, dependent: :destroy
  has_one :conciliation_information, dependent: :destroy


  before_save :set_amortization_value
  after_commit :create_payment, except: :destroy


  def set_amortization_value
        if self.cuota_value.nil?
              self.update(cuota_value: self.amortization_value)
        end
  end

  def create_payment
    if can_create_payment?
      Payment.create({billing_document_id: self.billing_document_id, 
        status: "active", 
        payment_source: "payment_agreement", 
        payment_method: "payment_agreement", 
        value: self.value, 
        resource_type: "PaymentAgreement", 
        resource_id: self.id, 
        payment_date: Time.now.to_date
      })
    end
  end

  def amortization_value
        start_date = self.created_at.nil? ? Time.now.to_date : self.created_at.to_date
    amortization_payment(self.value,self.rate,self.number_payments, self.start_date, self.start_date)
  end

  private

  def can_create_payment?
    self.status == 'valid' && self.payment.nil? && self.agreement_case == 'normalization'
  end
end
