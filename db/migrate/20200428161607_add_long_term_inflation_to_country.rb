class AddLongTermInflationToCountry < ActiveRecord::Migration[5.2]
  def change
    add_column :countries, :long_term_inflation, :float, default: 3
  end
end
