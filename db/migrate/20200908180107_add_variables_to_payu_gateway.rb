class AddVariablesToPayuGateway < ActiveRecord::Migration[5.2]
  def change
    add_column :payu_gateways, :fixed_fee, :float
    add_column :payu_gateways, :variable_fee, :float
  end
end
