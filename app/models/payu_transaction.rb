class PayuTransaction < ApplicationRecord
      
      resourcify
      audited
  belongs_to :billing_document
  has_one :payu_response, dependent: :destroy
  has_one :payu_confirmation, class_name: 'PayuTransaction',primary_key:  :reference_sale, foreign_key: 'external_id'

  belongs_to :payu_gateway

  after_create :set_external_id
  after_commit :finish_transaction



  def set_external_id
    if self.external_id.nil?
  	 self.update(external_id: Digest::MD5.hexdigest("transaction - #{self.id}"),status: 'started')
    end
  end

  def finish_transaction
  	if self.status != 'finished' && !self.payu_response.nil? && self.payu_response.code == 'ERROR'
  		self.update(status: 'finished')
  	end
  end

  def state
    self.payu_response.state
  end

  def user
    self.billing_document.user
  end

  def user_email
    self.billing_document.user_name
  end

end
