class MercadoPagoTransaction < ApplicationRecord
	resourcify
	audited

	belongs_to :billing_document
	belongs_to :mercado_pago_gateway
  has_one :mercado_pago_response, dependent: :destroy

  after_create :set_external_id
  after_commit :finish_transaction


	def set_external_id
    if self.external_id.nil?
  	 self.update(external_id: Digest::MD5.hexdigest("mercado-pago-transaction - #{self.id}"), status: 'started')
    end
  end

  def finish_transaction
  	if self.status != 'finished' && !self.mercado_pago_response.nil?
  	  self.update(status: 'finished')
  	end
  end

  def state
    self.mercado_pago_response.status
  end

  def gateway
    self.mercado_pago_gateway
  end

  def user
    self.billing_document.user
  end

  def user_email
    self.billing_document.user_name
  end
end
