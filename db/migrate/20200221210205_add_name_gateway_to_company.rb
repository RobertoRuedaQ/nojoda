class AddNameGatewayToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :name_for_gateway, :string
    add_column :companies, :company_legal_id, :string
  end
end
