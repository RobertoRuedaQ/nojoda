class NotifyEndOfContractAsync
	include Sidekiq::Worker

	sidekiq_options queue: 'heavy_work'

  def perform(user_id, supervisor_id)
    NotifyEndOfContractService.for(user_id, supervisor_id)
  end

end