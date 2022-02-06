class SendEmailsDynamicallyService
  def self.for(user_id, email_case)
    user = User.find(user_id)
    email_case = email_case
    return if user.nil?
    new(user).perform(email_case)
  end

  def initialize(user)
    @user = user
  end

  def perform(email_case)
    send_emails_dynamically(email_case)
  end
  
  private
  
  def send_emails_dynamically(email_case)
    CommunicationMailer.send(email_case, @user.id, @user.company_id).deliver
  end
end