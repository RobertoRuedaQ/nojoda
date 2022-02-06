class AddPayuGatewayToPayuTransaction < ActiveRecord::Migration[5.2]
  def change
    add_reference :payu_transactions, :payu_gateway, foreign_key: true
  end
end
