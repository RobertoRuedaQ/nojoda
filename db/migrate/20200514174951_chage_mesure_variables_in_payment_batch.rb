class ChageMesureVariablesInPaymentBatch < ActiveRecord::Migration[5.2]
  def change
  	change_column :payment_batches, :target_isas, :text
  	change_column :payment_batches, :processed_isas, :text
  	change_column :payment_batches, :error_isas, :text
  end
end

