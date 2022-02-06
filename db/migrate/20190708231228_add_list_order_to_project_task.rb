class AddListOrderToProjectTask < ActiveRecord::Migration[5.2]
  def change
    add_column :project_tasks, :list_order, :integer
  end
end
