class AddPaymentsToPaymentMassDoc < ActiveRecord::Migration[5.2]
  def change
    add_reference :payment_mass_docs, :payment, foreign_key: true
  end
end
