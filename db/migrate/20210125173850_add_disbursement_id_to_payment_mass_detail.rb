class AddDisbursementIdToPaymentMassDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_mass_details, :disbursement_id, :integer
  end
end
