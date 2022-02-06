class AddFinancialInformationToStudentExpenses < ActiveRecord::Migration[5.2]
  def change
    add_reference :student_expenses, :student_financial_information, foreign_key: true
  end
end
