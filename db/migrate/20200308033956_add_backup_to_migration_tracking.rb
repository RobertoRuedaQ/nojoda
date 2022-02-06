class AddBackupToMigrationTracking < ActiveRecord::Migration[5.2]
  def change
    add_column :migration_trackings, :backup, :text
  end
end
