class AddGeographyElementToGeography < ActiveRecord::Migration[5.2]
  def change
    add_column :geographies, :type_of_geography, :string
  end
end
