class SendEmailPendingDisbursementApplicationAsync
	include Sidekiq::Worker

	sidekiq_options queue: 'heavy_work'

  def perform(user_id, application_id)
    SendEmailPendingDisbursementApplicationService.for(user_id, application_id)
  end

end