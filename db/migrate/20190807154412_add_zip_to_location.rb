class AddZipToLocation < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :zip_code, :string
  end
end
