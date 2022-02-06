module LumniCollection

	def generate_billing_documents batch_id
		batch = PaymentBatch.cached_find(batch_id)
    	target_contracts_ids = Isa.to_generate_billing_document(batch.fund_id).pluck(:id).uniq
    	target_contracts = Isa.where(id: target_contracts_ids)
    	batch.update(target_isas: target_contracts.count)
    	batch.batch_detail.update_all(status: 'pending')

    	target_contracts.each_with_index do |isa, index|
    		BillingDocumentGenertionAsync.perform_async(isa.id, batch_id)
    	end
	end
	def activate_billing_documents batch_id
		batch = PaymentBatch.cached_find(batch_id)
		BillingDocument.where(payment_batch_id: batch.id,active: [nil,false]).map(&:activate_billing_document)
	end
end