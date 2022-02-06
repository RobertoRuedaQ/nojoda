class AddPositionToObjectOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :object_orders, :position, :integer
  end
end
