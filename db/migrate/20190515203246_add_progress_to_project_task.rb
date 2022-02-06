class AddProgressToProjectTask < ActiveRecord::Migration[5.2]
  def change
    add_column :project_tasks, :progress, :decimal
  end
end
