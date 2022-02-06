class FundingToken < ApplicationRecord
      
      resourcify
      audited
  belongs_to :funding_opportunity, touch: true
  belongs_to :user, touch: true, optional: true
  has_many :custom_disbursement,->{order(:forcasted_date)}
  belongs_to :student_token_batch, optional: true

  after_commit :send_invite

  def send_invite
  	if (self.email_sent.nil? || self.email_sent == false) && !self.target_email.nil?
  		CommunicationMailer.invite_mail_with_token( self.funding_opportunity.invite_template_id, self.id,self.funding_opportunity.company_id).deliver
  		self.update(email_sent: true)
  	end
  end
end
