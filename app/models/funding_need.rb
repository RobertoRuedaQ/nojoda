class FundingNeed < ApplicationRecord
      
      resourcify
      audited
  belongs_to :student_academic_information
end
