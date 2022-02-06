class AddFundNameToPaymentMassDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_mass_details, :fund_name, :string
    add_reference :payment_mass_details, :fund, foreign_key: true
  end
end
