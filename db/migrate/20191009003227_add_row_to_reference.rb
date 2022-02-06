class AddRowToReference < ActiveRecord::Migration[5.2]
  def change
    add_column :references, :row, :integer
  end
end
