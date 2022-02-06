class AddMexicanLocationToLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :municipality, :string
    add_column :locations, :neighborhood, :string
  end
end
