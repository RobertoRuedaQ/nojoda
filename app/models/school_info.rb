class SchoolInfo < ApplicationRecord
      
      resourcify
      audited
  belongs_to :student_academic_information,touch: true
end
