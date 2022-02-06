class AddStatusToPaymentBatch < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_batches, :status, :string
  end
end
