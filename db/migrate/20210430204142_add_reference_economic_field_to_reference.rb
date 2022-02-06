class AddReferenceEconomicFieldToReference < ActiveRecord::Migration[5.2]
  def change
    add_column :references, :reference_economic_field, :string
  end
end
