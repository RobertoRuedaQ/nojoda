class AddFinalSummaryToDisbursement < ActiveRecord::Migration[5.2]
  def change
    add_column :disbursements, :adjusted_student_value, :float
    add_column :disbursements, :payed_by_student, :float
  end
end
