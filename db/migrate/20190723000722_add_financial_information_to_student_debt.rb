class AddFinancialInformationToStudentDebt < ActiveRecord::Migration[5.2]
  def change
    add_reference :student_debts, :student_financial_information, foreign_key: true
  end
end
