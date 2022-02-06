class AddCheckFinishedProgramCheckToStudentAcademicInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :student_academic_informations, :finished_major_check, :boolean
    add_column :student_academic_informations, :on_hold_check, :boolean
  end
end
