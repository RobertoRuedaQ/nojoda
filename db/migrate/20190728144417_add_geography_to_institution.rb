class AddGeographyToInstitution < ActiveRecord::Migration[5.2]
  def change
    add_reference :institutions, :city, index: true
    add_reference :institutions, :state, index: true
    add_reference :institutions, :country, index: true
  end
end
