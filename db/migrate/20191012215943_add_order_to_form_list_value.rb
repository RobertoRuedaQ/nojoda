class AddOrderToFormListValue < ActiveRecord::Migration[5.2]
  def change
    add_column :form_list_values, :order, :integer
  end
end
