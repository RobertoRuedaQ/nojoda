class AddLocationToStudentAcademicInformation < ActiveRecord::Migration[5.2]
  def change
    add_reference :student_academic_informations, :city, index: true
    add_reference :student_academic_informations, :state, index: true
    add_reference :student_academic_informations, :country, index: true
  end
end
