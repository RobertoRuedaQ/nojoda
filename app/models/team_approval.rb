class TeamApproval < ApplicationRecord
  resourcify
  belongs_to :team_profile
  belongs_to :role
end
