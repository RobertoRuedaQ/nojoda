class AddCityAndStateCodeToInstitution < ActiveRecord::Migration[5.2]
  def change
    add_column :institutions, :city_internal_code, :string
    add_column :institutions, :state_internal_code, :string
  end
end
