class AddIsaToPaymentAgreement < ActiveRecord::Migration[5.2]
  def change
    add_reference :payment_agreements, :isa, foreign_key: true
  end
end
