class AddRangeFieldsToStudentAcademicInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :student_academic_informations, :min_value_grade, :integer
    add_column :student_academic_informations, :max_value_grade, :integer
  end
end
