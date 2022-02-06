class AddStartDateToProjectTask < ActiveRecord::Migration[5.2]
  def change
    add_column :project_tasks, :start_date, :date
  end
end
