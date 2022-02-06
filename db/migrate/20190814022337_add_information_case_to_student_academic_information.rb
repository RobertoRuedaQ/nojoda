class AddInformationCaseToStudentAcademicInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :student_academic_informations, :information_case, :string
  end
end
