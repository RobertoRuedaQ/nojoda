class AddObjectToDocsField < ActiveRecord::Migration[5.2]
  def change
    add_column :docs_fields, :object, :string
    add_column :docs_generals, :controller, :string
    remove_column :docs_generals, :object
  end
end
