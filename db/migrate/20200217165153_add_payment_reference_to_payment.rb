class AddPaymentReferenceToPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :payment_reference, :string
  end
end
