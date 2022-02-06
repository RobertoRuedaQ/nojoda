class AddAccountReceivableToDisbursementPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :disbursement_payments, :account_receivable, :boolean, default: false
  end
end
