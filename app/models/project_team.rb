class ProjectTeam < ApplicationRecord
  resourcify
  audited
  belongs_to :user
  belongs_to :project
end
