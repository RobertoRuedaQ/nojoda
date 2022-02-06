class AddDisbursementValueToStudentAcademicInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :student_academic_informations, :disbursement_value, :float
  end
end
