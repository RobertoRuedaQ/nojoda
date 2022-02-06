class RemovePaymentMatchFromBatchDetail < ActiveRecord::Migration[5.2]
  def change
  	remove_reference :batch_details, :payment_match
  end
end
