class AddMarginErrorToPaymentMass < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_masses, :margin_error, :integer, default: 0
  end
end
