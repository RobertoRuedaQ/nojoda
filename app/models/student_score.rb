class StudentScore < ApplicationRecord
  resourcify
  audited
  belongs_to :questionnaire
end
