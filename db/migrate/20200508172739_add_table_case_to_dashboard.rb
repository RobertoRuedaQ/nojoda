class AddTableCaseToDashboard < ActiveRecord::Migration[5.2]
  def change
    add_column :dashboards, :table_case, :string
  end
end
