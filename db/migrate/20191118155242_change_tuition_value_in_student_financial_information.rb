class ChangeTuitionValueInStudentFinancialInformation < ActiveRecord::Migration[5.2]
  def change
  	  	remove_column :student_academic_informations, :tuition_value, :boolean
  	  	add_column :student_academic_informations, :tuition_value, :float
  end
end
