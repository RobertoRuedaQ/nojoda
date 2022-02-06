class ChangeAutomaticDoneFromProjectTask < ActiveRecord::Migration[5.2]
  def change
  	change_column :project_tasks, :automatic_done, :boolean, default: false, null: false
  end
end
