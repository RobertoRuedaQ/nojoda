class AddConflictToSociodemographic < ActiveRecord::Migration[5.2]
  def change
    add_column :sociodemographics, :confict_involvement, :boolean
  end
end
