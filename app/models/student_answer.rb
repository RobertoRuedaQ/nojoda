class StudentAnswer < ApplicationRecord
  resourcify
  audited
  belongs_to :student_score
  belongs_to :answers
end
