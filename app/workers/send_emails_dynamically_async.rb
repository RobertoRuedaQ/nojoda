class SendEmailsDynamicallyAsync
	include Sidekiq::Worker

	sidekiq_options queue: 'heavy_work'

  def perform(user_id, email_case)
    SendEmailsDynamicallyService.for(user_id, email_case)
  end

end