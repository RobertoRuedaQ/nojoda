class AddMatchesCountToPaymentMassDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_mass_details, :matches_count, :integer
  end
end
