class AddLivingExpensesCheckToStudentAcademicInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :student_academic_informations, :living_expenses_check, :boolean
    add_column :student_academic_informations, :living_expenses_value, :boolean
    add_column :student_academic_informations, :tuition_value, :boolean
    add_column :student_academic_informations, :tuition_funded_percentage, :boolean
  end
end
