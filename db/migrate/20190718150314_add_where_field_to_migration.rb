class AddWhereFieldToMigration < ActiveRecord::Migration[5.2]
  def change
    add_column :migrations, :where_field, :text
  end
end
