class PersonalCovidEmergency < ApplicationRecord
      
      resourcify
      audited
  belongs_to :user
end
