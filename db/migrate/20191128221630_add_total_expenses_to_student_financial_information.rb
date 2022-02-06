class AddTotalExpensesToStudentFinancialInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :student_financial_informations, :total_expenses, :float
  end
end
