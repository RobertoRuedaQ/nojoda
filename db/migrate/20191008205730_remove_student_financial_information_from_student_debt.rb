class RemoveStudentFinancialInformationFromStudentDebt < ActiveRecord::Migration[5.2]
  def change
    remove_reference :student_debts, :student_financial_information, foreign_key: true
  end
end
