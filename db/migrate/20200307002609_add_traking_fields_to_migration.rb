class AddTrakingFieldsToMigration < ActiveRecord::Migration[5.2]
  def change
    add_column :migrations, :target_number, :integer
    add_column :migrations, :processed_records, :integer
  end
end
