class AddStatusToDisbursementPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :disbursement_payments, :status, :string
  end
end
