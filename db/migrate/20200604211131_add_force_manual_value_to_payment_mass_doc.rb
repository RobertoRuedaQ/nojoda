class AddForceManualValueToPaymentMassDoc < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_mass_docs, :force_manual_value, :boolean
  end
end
