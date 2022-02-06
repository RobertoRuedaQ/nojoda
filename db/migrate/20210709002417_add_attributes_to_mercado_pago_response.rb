class AddAttributesToMercadoPagoResponse < ActiveRecord::Migration[5.2]
  def change
    add_column :mercado_pago_responses, :authorization_code, :string
    add_column :mercado_pago_responses, :currency_id, :string
    add_column :mercado_pago_responses, :date_approved, :string
    add_column :mercado_pago_responses, :payment_method, :string
    add_column :mercado_pago_responses, :transaction_amount, :string
  end
end
