class AddStudentAcademicInformationToIsa < ActiveRecord::Migration[5.2]
  def change
    add_reference :isas, :student_academic_information, foreign_key: true
  end
end
