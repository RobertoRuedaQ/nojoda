class RemoveHealthFromSociodemographic < ActiveRecord::Migration[5.2]
  def change
    remove_column :sociodemographics, :disabilities, :boolean
    remove_column :sociodemographics, :health_coverage, :string
    remove_column :sociodemographics, :health_ranking, :string
  end
end
