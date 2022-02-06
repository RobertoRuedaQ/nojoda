class AddGraduationDateLastAcademicLevelFulfilledToStudentAcademicInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :student_academic_informations, :graduation_date_last_academic_level_fulfilled, :date
  end
end
