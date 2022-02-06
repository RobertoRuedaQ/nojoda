class CommunicationUser < ApplicationRecord
      
      resourcify
      audited
  belongs_to :user
end
