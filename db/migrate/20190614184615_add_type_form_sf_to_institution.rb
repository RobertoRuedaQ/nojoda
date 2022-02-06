class AddTypeFormSfToInstitution < ActiveRecord::Migration[5.2]
  def change
    add_column :institutions, :type_from_sf, :string
  end
end
