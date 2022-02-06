class ApiHistory < ApplicationRecord
      
      resourcify
      audited
  belongs_to :user, optional: true
end
