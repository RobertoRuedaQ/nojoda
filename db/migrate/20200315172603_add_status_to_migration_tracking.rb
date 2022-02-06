class AddStatusToMigrationTracking < ActiveRecord::Migration[5.2]
  def change
    add_column :migration_trackings, :status, :string
  end
end
