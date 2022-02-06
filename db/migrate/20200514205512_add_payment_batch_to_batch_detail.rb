class AddPaymentBatchToBatchDetail < ActiveRecord::Migration[5.2]
  def change
    add_reference :batch_details, :payment_batch, foreign_key: true
  end
end
