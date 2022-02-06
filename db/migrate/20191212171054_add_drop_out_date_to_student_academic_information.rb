class AddDropOutDateToStudentAcademicInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :student_academic_informations, :drop_out_date, :date
  end
end
