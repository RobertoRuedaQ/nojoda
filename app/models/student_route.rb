class StudentRoute < ApplicationRecord
      
      resourcify
      audited
  belongs_to :team_profile
  	belongs_to :resource, polymorphic: true

end
