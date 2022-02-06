class AddSfFieldsToMigration < ActiveRecord::Migration[5.2]
  def change
    add_column :migrations, :sf_object, :string
    add_column :migrations, :function_text, :string
    add_column :migrations, :status, :string
  end
end
