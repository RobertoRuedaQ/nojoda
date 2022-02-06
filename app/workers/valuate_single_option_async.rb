class ValuateSingleOptionAsync < ApplicationController
	include Sidekiq::Worker
	include LumniMigration
	include LumniRoles

	sidekiq_options queue: 'heavy_work'

	def perform funding_option_id, valuation_history_id
		FundingOption.find(funding_option_id).model_with_r(valuation_history_id)
	end
end