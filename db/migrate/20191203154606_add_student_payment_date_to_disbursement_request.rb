class AddStudentPaymentDateToDisbursementRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :disbursement_requests, :payment_date_to_institution, :date
  end
end
