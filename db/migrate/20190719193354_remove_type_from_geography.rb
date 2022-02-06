class RemoveTypeFromGeography < ActiveRecord::Migration[5.2]
  def change
    remove_column :geographies, :type, :string
  end
end
