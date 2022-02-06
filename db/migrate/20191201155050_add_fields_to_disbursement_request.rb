class AddFieldsToDisbursementRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :disbursement_requests, :disbursement_case, :string
    add_column :disbursement_requests, :tuition_due_date_type, :string
    add_column :disbursement_requests, :value_payed_by_student_check, :boolean
    add_column :disbursement_requests, :payment_target, :string
    add_column :disbursement_requests, :student_payment_date, :date
    add_column :disbursement_requests, :student_payment_income_source, :string
  end
end
