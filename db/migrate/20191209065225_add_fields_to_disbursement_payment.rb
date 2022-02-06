class AddFieldsToDisbursementPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :disbursement_payments, :notes, :text
    add_column :disbursement_payments, :request_support, :boolean
  end
end
