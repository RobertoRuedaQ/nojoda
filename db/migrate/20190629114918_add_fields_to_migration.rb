class AddFieldsToMigration < ActiveRecord::Migration[5.2]
  def change
    add_column :migrations, :name, :string
    add_column :migrations, :type_of_migration, :string
  end
end
