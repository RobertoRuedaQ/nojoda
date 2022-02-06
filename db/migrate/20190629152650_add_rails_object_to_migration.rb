class AddRailsObjectToMigration < ActiveRecord::Migration[5.2]
  def change
    add_column :migrations, :rails_object, :string
  end
end
