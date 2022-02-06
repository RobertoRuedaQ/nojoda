class AddDroppedOutToStudentAcademicInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :student_academic_informations, :drop_out, :boolean
  end
end
