class AddMercadoPagoTransactionToMercadoPagoResponse < ActiveRecord::Migration[5.2]
  def change
    add_reference :mercado_pago_responses, :mercado_pago_transaction, foreign_key: true
  end
end
