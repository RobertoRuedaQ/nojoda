class AddOrderToOriginationSection < ActiveRecord::Migration[5.2]
  def change
    add_column :origination_sections, :order, :integer
  end
end
