class AddValueToPaymentMatch < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_matches, :value, :float
  end
end
