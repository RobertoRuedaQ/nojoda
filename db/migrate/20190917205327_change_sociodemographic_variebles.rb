class ChangeSociodemographicVariebles < ActiveRecord::Migration[5.2]
  def change
  	change_column :sociodemographics, :children_number, :string
  	change_column :sociodemographics, :siblings_number, :string
  	change_column :sociodemographics, :siblings_position, :string
  	change_column :sociodemographics, :dependent_number, :string
  	change_column :sociodemographics, :strata, :string
  end
end
