class PayuConfirmation < ApplicationRecord

	belongs_to :payu_transaction, class_name: 'PayuTransaction',primary_key:  :external_id, foreign_key: 'reference_sale'
      
  resourcify
  audited

  after_commit :update_response_async

	def update_response_async
    PerformServiceAsync.perform_in(20.seconds, 'UpdatePayuConfirmationResponseService', self.id )
	end  
end
