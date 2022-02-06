class AddFileOriginKeyToPaymentMassDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_mass_details, :origin_file_key, :string
  end
end
