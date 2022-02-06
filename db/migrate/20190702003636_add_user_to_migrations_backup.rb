class AddUserToMigrationsBackup < ActiveRecord::Migration[5.2]
  def change
    add_reference :migrations_backups, :user, foreign_key: true
  end
end
