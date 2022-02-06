class AddReadCheckToProjectTask < ActiveRecord::Migration[5.2]
  def change
    add_column :project_tasks, :read_check, :boolean
  end
end
