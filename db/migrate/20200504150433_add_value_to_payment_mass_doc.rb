class AddValueToPaymentMassDoc < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_mass_docs, :value, :float
  end
end
