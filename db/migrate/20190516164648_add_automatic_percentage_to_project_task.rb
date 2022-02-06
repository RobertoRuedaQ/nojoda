class AddAutomaticPercentageToProjectTask < ActiveRecord::Migration[5.2]
  def change
    add_column :project_tasks, :automatic_percentage, :decimal
  end
end
