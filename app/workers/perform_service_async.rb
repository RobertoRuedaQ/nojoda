class PerformServiceAsync < ApplicationController
	include Sidekiq::Worker

	sidekiq_options queue: 'heavy_work'

  def perform(service, params={})
    service.classify.constantize.for(params)
  end

end