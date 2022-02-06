class ActivitiesDetail < ApplicationRecord
      
      resourcify
      audited
  belongs_to :user
end
