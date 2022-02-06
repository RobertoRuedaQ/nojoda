class AddColumnsToSociodemographic < ActiveRecord::Migration[5.2]
  def change
    add_column :sociodemographics, :birthplace_type, :string
    add_column :sociodemographics, :living_place_type, :string
    add_column :sociodemographics, :head_of_the_family, :string
    add_column :sociodemographics, :family_provider, :string
  end
end
