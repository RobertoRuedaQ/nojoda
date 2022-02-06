class AddErrorInfoToBatchDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :batch_details, :error_text, :string
    add_column :batch_details, :error_backlog, :text
  end
end
