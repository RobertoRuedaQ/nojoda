class AddStatusToCollection < ActiveRecord::Migration[5.2]
  def change
    add_column :collections, :status, :string
  end
end
