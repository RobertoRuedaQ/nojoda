class AddResourceToApplication < ActiveRecord::Migration[5.2]
  def change
    add_reference :applications, :resource, polymorphic: true, index: true
  end
end
