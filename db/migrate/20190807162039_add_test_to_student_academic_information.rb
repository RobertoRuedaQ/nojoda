class AddTestToStudentAcademicInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :student_academic_informations, :institution_nature, :string
    add_column :student_academic_informations, :standardized_state_test_check, :boolean
    add_column :student_academic_informations, :standardized_state_test_result, :string
    add_column :student_academic_informations, :standardized_state_test_date, :date
  end
end
