class AddTopRateCapToPaymentConfig < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_configs, :top_rate_cap, :float, :default =>  0
  end
end
