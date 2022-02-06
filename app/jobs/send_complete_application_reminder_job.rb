class SendCompleteApplicationReminderJob < ApplicationJob
  queue_as :worker
  
  def perform
    Application.send_email_for_pending_disbursement_application
  end
end