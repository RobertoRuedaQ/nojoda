class AddDisbursementsFieldsToStudentAcademicInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :student_academic_informations, :number_of_disbursements_requiered, :integer
    add_column :student_academic_informations, :disbursements_periodicity, :integer
    add_column :student_academic_informations, :first_disbursement_date, :date
  end
end
