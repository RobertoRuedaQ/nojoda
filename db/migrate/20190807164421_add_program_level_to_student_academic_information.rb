class AddProgramLevelToStudentAcademicInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :student_academic_informations, :program_level, :string
  end
end
