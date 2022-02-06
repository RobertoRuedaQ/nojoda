class AddStatusDetailToMercadoPagoResponses < ActiveRecord::Migration[5.2]
  def change
    add_column :mercado_pago_responses, :status_detail, :string
  end
end
