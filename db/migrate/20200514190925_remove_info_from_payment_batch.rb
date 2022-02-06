class RemoveInfoFromPaymentBatch < ActiveRecord::Migration[5.2]
  def change
    remove_column :payment_batches, :processed_isas
    remove_column :payment_batches, :error_isas
    remove_column :payment_batches, :target_isas
    add_column :payment_batches, :target_isas, :integer
  end
end
