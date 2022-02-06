class AddOptionsToMigration < ActiveRecord::Migration[5.2]
  def change
    add_column :migrations, :options, :string
  end
end
