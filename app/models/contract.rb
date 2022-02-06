class Contract < ApplicationRecord
      
      resourcify
      audited
  belongs_to :user
  belongs_to :application
end
