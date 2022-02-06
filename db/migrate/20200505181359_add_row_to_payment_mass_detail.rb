class AddRowToPaymentMassDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_mass_details, :row, :integer
  end
end
