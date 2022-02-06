class AddNewLocationFieldsToLocation < ActiveRecord::Migration[5.2]
  def change
    add_reference :locations, :country, index: true
    add_reference :locations, :state, index: true
    add_reference :locations, :city, index: true
  end
end
