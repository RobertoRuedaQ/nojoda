class GeneralRequest < ApplicationRecord
      
      resourcify
      audited
  belongs_to :user
end
