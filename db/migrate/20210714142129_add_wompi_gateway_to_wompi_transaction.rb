class AddWompiGatewayToWompiTransaction < ActiveRecord::Migration[5.2]
  def change
    remove_reference :wompi_transactions, :mercado_pago_gateway, foreign_key: true
    add_reference :wompi_transactions, :wompi_gateway, foreign_key: true
  end
end