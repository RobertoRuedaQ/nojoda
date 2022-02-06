class StudentReview < ApplicationRecord
      
      resourcify
      audited
  belongs_to :user
  belongs_to :created_by,class_name: 'User', foreign_key: 'created_by_id'
end
