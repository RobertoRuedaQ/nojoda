class AddMigrationToMigration < ActiveRecord::Migration[5.2]
  def change
    add_reference :migrations, :migration, foreign_key: true
  end
end
