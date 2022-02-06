class CollectionAsync < ApplicationController
	include Sidekiq::Worker
	sidekiq_options queue: 'default'
	include LumniCollection

	def perform batch, action
		eval("#{action}(batch)")
	end
end