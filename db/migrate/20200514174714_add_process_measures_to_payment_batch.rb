class AddProcessMeasuresToPaymentBatch < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_batches, :target_isas, :string
    add_column :payment_batches, :processed_isas, :string
    add_column :payment_batches, :error_isas, :string
  end
end
