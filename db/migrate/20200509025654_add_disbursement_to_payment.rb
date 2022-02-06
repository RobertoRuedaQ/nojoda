class AddDisbursementToPayment < ActiveRecord::Migration[5.2]
  def change
    add_reference :payments, :disbursement, foreign_key: true
    remove_reference :payments, :target_record, index: true
  end
end
