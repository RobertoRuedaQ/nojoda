class AddInternationalCodeToCountry < ActiveRecord::Migration[5.2]
  def change
    add_column :countries, :international_code, :string
  end
end
