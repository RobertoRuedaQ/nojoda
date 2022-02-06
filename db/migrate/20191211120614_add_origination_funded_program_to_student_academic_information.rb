class AddOriginationFundedProgramToStudentAcademicInformation < ActiveRecord::Migration[5.2]
  def change
    add_reference :student_academic_informations, :funded_program, index: true
  end
end
