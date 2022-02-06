class RemoveFavoriteFromProject < ActiveRecord::Migration[5.2]
  def change
  	remove_column :projects, :favorite
  end
end
