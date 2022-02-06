class AddSocioToHealth < ActiveRecord::Migration[5.2]
  def change
    add_column :healths, :health_coverage, :string
    add_column :healths, :health_ranking, :string
  end
end
