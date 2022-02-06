class StudentDebt < ApplicationRecord
      
      resourcify
      audited
  belongs_to :user, touch: true
end
