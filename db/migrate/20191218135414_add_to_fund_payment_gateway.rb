class AddToFundPaymentGateway < ActiveRecord::Migration[5.2]
  def change
    add_reference :funds, :payment_gateway, polymorphic: true, index: true
  end
end
