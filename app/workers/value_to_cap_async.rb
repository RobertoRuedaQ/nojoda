class ValueToCapAsync < ApplicationController
	include Sidekiq::Worker
	sidekiq_options queue: 'default'

	def perform(funding_option_id, evaluation_date)
		funding_option = FundingOption.find(funding_option_id)
		UpdateValueToCapService.for(funding_option, evaluation_date)
	end
end