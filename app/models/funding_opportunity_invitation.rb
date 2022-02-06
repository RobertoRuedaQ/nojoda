class FundingOpportunityInvitation < ApplicationRecord
      
      resourcify
      audited
  belongs_to :funding_opportunity

  after_create :send_invite

  def send_invite
	CommunicationMailer.invite_mail_without_token( self.funding_opportunity.invite_template_id,self.funding_opportunity.company_id,self.target_email).deliver
  end


end
