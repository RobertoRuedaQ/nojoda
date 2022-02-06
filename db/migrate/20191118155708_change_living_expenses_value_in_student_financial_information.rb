class ChangeLivingExpensesValueInStudentFinancialInformation < ActiveRecord::Migration[5.2]
  def change
  	  	remove_column :student_academic_informations, :living_expenses_value, :boolean
  	  	add_column :student_academic_informations, :living_expenses_value, :float
  end
end
