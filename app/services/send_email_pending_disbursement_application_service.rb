class SendEmailPendingDisbursementApplicationService
  def self.for(user_id, application_id)
    user = User.find(user_id)
    application = Application.find(application_id)
    return if user.nil?
    new(user, application).perform
  end

  def initialize(user, application)
    @user = user
    @application = application
  end

  def perform
    send_email_pending_application_disbursement
  end

  private

  def send_email_pending_application_disbursement
    CommunicationMailer.reminder_complete_pending_application_disbursement(@user.id, @user.company_id, @application.id).deliver
  end
end