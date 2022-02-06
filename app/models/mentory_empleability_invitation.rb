class MentoryEmpleabilityInvitation < ApplicationRecord
  belongs_to :user

  def origination
    self.user.funding_opportunities.first.process_origination.mentory_empleability_invitation
  end
end