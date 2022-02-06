class AddIdentificationNumberToPaymentMassDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_mass_details, :identification_number, :string
  end
end
