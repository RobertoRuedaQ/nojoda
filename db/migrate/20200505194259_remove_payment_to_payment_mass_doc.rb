class RemovePaymentToPaymentMassDoc < ActiveRecord::Migration[5.2]
  def change
  	remove_reference :payment_mass_docs,:payment, foreing_key: true
  end
end
