class AddDetailsToReference < ActiveRecord::Migration[5.2]
  def change
    add_column :references, :labor_contract_case, :string
    add_column :references, :seniority, :string
  end
end
