class AddRequirementTypeToProjectTask < ActiveRecord::Migration[5.2]
  def change
    add_column :project_tasks, :requirement_type, :string
  end
end
