class StudentExpense < ApplicationRecord
      
      resourcify
      audited
      belongs_to :student_financial_information
end
