class AddStoredAcademicStatusToStudentAcademicInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :student_academic_informations, :stored_academic_information, :string
  end
end
