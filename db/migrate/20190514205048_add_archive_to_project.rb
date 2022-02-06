class AddArchiveToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :archive, :boolean
  end
end
