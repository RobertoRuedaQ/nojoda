class SupportRole < ApplicationRecord
      
      resourcify
      audited
      has_many :team_supervisor
      belongs_to :company, optional: true

      
end
