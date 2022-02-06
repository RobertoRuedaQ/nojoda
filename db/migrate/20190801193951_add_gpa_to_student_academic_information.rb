class AddGpaToStudentAcademicInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :student_academic_informations, :gpa, :float
  end
end
