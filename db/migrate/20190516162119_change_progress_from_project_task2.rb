class ChangeProgressFromProjectTask2 < ActiveRecord::Migration[5.2]
  def change
  	change_column :project_tasks, :progress, :decimal, default: 0
  end
end
