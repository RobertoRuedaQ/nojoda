class RemoveModelReferenceFromMigrationField < ActiveRecord::Migration[5.2]
  def change
    remove_column :migration_fields, :model_reference, :string
  end
end
