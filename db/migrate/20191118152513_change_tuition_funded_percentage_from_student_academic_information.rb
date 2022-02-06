class ChangeTuitionFundedPercentageFromStudentAcademicInformation < ActiveRecord::Migration[5.2]
  def change
  	  	remove_column :student_academic_informations, :tuition_funded_percentage, :boolean
  	  	add_column :student_academic_informations, :tuition_funded_percentage, :float
  end
end
