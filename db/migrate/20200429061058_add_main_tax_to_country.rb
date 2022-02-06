class AddMainTaxToCountry < ActiveRecord::Migration[5.2]
  def change
    add_column :countries, :main_tax_value, :float
  end
end
