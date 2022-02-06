class AddFixedValueToMigrationField < ActiveRecord::Migration[5.2]
  def change
    add_column :migration_fields, :fixed_value, :string
  end
end
