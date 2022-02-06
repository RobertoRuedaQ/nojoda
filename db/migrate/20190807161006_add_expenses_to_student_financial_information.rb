class AddExpensesToStudentFinancialInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :student_financial_informations, :entertainment_expenses, :float
    add_column :student_financial_informations, :home_expenses, :float
    add_column :student_financial_informations, :dependent_expenses, :float
    add_column :student_financial_informations, :personal_goods_expenses, :float
    add_column :student_financial_informations, :transportation_expenses, :float
    add_column :student_financial_informations, :food_expenses, :float
  end
end
