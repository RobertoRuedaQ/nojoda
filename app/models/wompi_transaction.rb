class WompiTransaction < ApplicationRecord
	resourcify
	audited

	belongs_to :billing_document
	belongs_to :wompi_gateway
	has_one :wompi_response, dependent: :destroy

  after_create :set_external_id
  after_commit :finish_transaction


	def set_external_id
    if self.external_id.nil?
  	 self.update(external_id: Digest::MD5.hexdigest("wompi-transaction - #{self.id}"), status: 'started')
    end
  end

  def finish_transaction
  	if self.status != 'finished' && !self.wompi_response.nil?
  	  self.update(status: 'finished')
  	end
  end


  def get_and_update_from_wompi_service
    ManageWompiResponseService.for(self)
  end

  def find_transaction_in_wompi_service
    return unless self.wompi_transaction_id.present?

    self.gateway.find_wompi_transaction_by_id(self.wompi_transaction_id)
  end

  def gateway
    self.wompi_gateway
  end

  def state
    self.payu_response.status
  end

  def user
    self.billing_document.user
  end

  def user_email
    self.billing_document.user.email
  end
end
