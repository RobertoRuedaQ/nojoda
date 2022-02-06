class AddObjectReferencesToMigrationField < ActiveRecord::Migration[5.2]
  def change
    add_column :migration_fields, :object_reference, :string
  end
end
