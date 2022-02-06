class AddApplicationToStudentAcademicInformation < ActiveRecord::Migration[5.2]
  def change
    add_reference :student_academic_informations, :application, foreign_key: true
  end
end
