class AddAdjustMigrationToMigrationTracking < ActiveRecord::Migration[5.2]
  def change
    add_column :migration_trackings, :adjust_migration, :integer
  end
end
