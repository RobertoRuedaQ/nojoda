class AddOriginRegionToSociodemographic < ActiveRecord::Migration[5.2]
  def change
    add_column :sociodemographics, :origin_region, :string
  end
end
