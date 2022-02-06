class AddAutomaticDoneToProjectTask < ActiveRecord::Migration[5.2]
  def change
    add_column :project_tasks, :automatic_done, :boolean
  end
end
