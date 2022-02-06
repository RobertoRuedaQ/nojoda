class SchoolGrade < ApplicationRecord
      
      resourcify
      audited
  belongs_to :student_academic_information
  has_one_attached :grade_certificate
end
