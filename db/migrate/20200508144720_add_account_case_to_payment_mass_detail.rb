class AddAccountCaseToPaymentMassDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_mass_details, :account_case, :string
  end
end
