class ChangeProgressFromProjectTask < ActiveRecord::Migration[5.2]
  def change
  	change_column :project_tasks, :progress, :integer, default: 0
  end
end
