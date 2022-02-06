class AddNameToPaymentMass < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_masses, :name, :string
  end
end
