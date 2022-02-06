class AddProgressToProject < ActiveRecord::Migration[5.2]
  def change
    add_column :projects, :progress, :decimal
  end
end
