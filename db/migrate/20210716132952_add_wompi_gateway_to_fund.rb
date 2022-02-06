class AddWompiGatewayToFund < ActiveRecord::Migration[5.2]
  def change
    add_reference :funds, :wompi_gateway, foreign_key: true
  end
end
