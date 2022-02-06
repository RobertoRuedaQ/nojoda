class AddStatusToPaymentMassDoc < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_mass_docs, :status, :string
  end
end
