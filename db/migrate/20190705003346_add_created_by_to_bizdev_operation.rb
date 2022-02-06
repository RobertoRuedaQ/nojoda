class AddCreatedByToBizdevOperation < ActiveRecord::Migration[5.2]
  def change
    add_reference :bizdev_operations, :created_by, index: true
  end
end
