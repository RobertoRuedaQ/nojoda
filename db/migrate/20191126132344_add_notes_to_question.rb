class AddNotesToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :notes, :text
  end
end
