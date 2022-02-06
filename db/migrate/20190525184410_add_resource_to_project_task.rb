class AddResourceToProjectTask < ActiveRecord::Migration[5.2]
  def change
    add_reference :project_tasks, :resource, polymorphic: true, index: true
  end
end
