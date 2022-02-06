class StudentConfig < ApplicationRecord
      
      resourcify
      audited
  belongs_to :user
end
