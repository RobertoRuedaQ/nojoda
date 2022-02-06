class AddFieldsToCollection < ActiveRecord::Migration[5.2]
  def change
    add_column :collections, :affiliation_status, :string
    add_column :collections, :system, :string
    add_column :collections, :affiliation_type, :string
  end
end
