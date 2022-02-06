class AddControlVariablesToPaymentMassDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_mass_details, :status, :string
    add_column :payment_mass_details, :problem_case, :string
  end
end
