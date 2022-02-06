class UserAggregation < ApplicationRecord
      
      resourcify
      audited
  belongs_to :user
end
