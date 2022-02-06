class AddMexicanLocationToReference < ActiveRecord::Migration[5.2]
  def change
    add_column :references, :municipality, :string
    add_column :references, :neighborhood, :string
  end
end
