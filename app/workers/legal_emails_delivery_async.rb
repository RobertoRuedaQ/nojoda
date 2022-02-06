class LegalEmailsDelyveryAsync < ApplicationController
	include LumniOrigination
	include Sidekiq::Worker
	sidekiq_options queue: 'heavy_work'

	def perform user_id, legal_match_id
		CommunicationMailer.legal_document_mail(user_id,legal_match_id).deliver
	end
end