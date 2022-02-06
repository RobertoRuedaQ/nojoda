class MercadoPagoResponse < ApplicationRecord
      
	resourcify
	audited

	belongs_to :mercado_pago_transaction, touch: true
	has_one :payment, as: :resource , dependent: :destroy

	after_commit :create_payment


	def create_payment
		return unless self.payment.nil?

		if self.status == 'approved'
			payment_date = self.created_at ? self.created_at : Time.zone.now.to_date
			Payment.create({
				billing_document_id: self.mercado_pago_transaction.billing_document_id, 
				status: 'active', 
				payment_source: 'electronic_payment', 
				payment_method: self.payment_method, 
				value: self.mercado_pago_transaction.value,
				resource_type: 'MercadoPagoResponse',
				resource_id: self.id,
				payment_date: payment_date
			})
		end
	end

	def get_updated_response
    gateway = self.mercado_pago_transaction.gateway
		updated = gateway.get_payment_by_id(self.payment_id)
		return updated[:response]
  end

	def update_response
		if self.status != 'approved' || self.payment_method.nil? || self.status_detail.nil?
      new_response = self.get_updated_response
      self.update({
				status: new_response['status'],
				authorization_code: new_response['authorization_code'],
				currency_id: new_response['currency_id'],
				date_approved: new_response['date_approved'],
				payment_method: new_response['payment_method_id'],
				transaction_amount: new_response['transaction_amount'],
				status_detail: new_response['status_detail']
			})
    end

    return self
	end


	def billing_document
    self.mercado_pago_transaction.billing_document
  end

  def user
    self.mercado_pago_transaction.user
  end

	def user_name
    self.user.name
  end

  def user_identification_number
    self.user.identification_number
  end

  def set_last_review_date
    self.last_review_datetime = Time.now
  end

  def fund_name
    self.fund.name
  end

  def value 
    self.mercado_pago_transaction.value
  end

  def fund
    self.billing_document.fund
  end
end
