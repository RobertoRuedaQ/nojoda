class RemoveLocationFieldsFromInstitution < ActiveRecord::Migration[5.2]
  def change
    remove_reference :institutions, :city, index: true
    remove_reference :institutions, :state, index: true
    remove_reference :institutions, :country, index: true
  end
end
