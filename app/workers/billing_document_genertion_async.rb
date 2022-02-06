class BillingDocumentGenertionAsync < ApplicationController
	include Sidekiq::Worker
	include LumniCollection

	sidekiq_options queue: 'heavy_work'
	def perform isa_id, batch_id
		isa = Isa.find(isa_id)
		batch = PaymentBatch.find(batch_id)
		isa.manage_document_generation(batch)
	end
end


#4833,191