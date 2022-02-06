class AddAttrubutesToMercadoPago < ActiveRecord::Migration[5.2]
  def change
    add_reference :mercado_pago_gateways, :company, foreign_key: true
    add_column :mercado_pago_gateways, :gateway_case, :string, default: ''
    add_column :mercado_pago_gateways, :public_key, :string, default: ''
    add_column :mercado_pago_gateways, :access_token, :string, default: ''
    add_column :mercado_pago_gateways, :app_id, :string, default: ''
    add_column :mercado_pago_gateways, :name, :string, default: ''
  end
end
