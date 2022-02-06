class AddPaymentDateToDisbursementPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :disbursement_payments, :payment_date, :date
  end
end
