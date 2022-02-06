class RemoveNameFromBizdevProduction < ActiveRecord::Migration[5.2]
  def change
    remove_column :bizdev_operations, :name, :string
    remove_column :bizdev_operations, :phase, :string
  end
end
