class SencibilityAnalisysAsync < ApplicationController
	include Sidekiq::Worker
	include LumniMigration
	include LumniRoles

	sidekiq_options queue: 'heavy_work'

	def perform main_id, target_funding_opportunity_ids
		ModelingMainSencibility.find(main_id).execute_first_analisys(target_funding_opportunity_ids)
	end
end