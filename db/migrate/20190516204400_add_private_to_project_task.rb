class AddPrivateToProjectTask < ActiveRecord::Migration[5.2]
  def change
    add_column :project_tasks, :private, :boolean, default: false, null: false
  end
end
