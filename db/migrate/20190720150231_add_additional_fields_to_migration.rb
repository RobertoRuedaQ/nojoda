class AddAdditionalFieldsToMigration < ActiveRecord::Migration[5.2]
  def change
    add_column :migrations, :additional_fields, :text
  end
end
