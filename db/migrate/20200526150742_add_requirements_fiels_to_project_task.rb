class AddRequirementsFielsToProjectTask < ActiveRecord::Migration[5.2]
  def change
    add_column :project_tasks, :task_source, :string
    add_column :project_tasks, :expected_response_time, :integer
    add_column :project_tasks, :response, :text
    add_column :project_tasks, :priority, :string
    add_column :project_tasks, :task_case, :string
    add_column :project_tasks, :task_score, :float
  end
end
