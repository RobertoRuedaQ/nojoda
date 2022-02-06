class AddOriginalApplicationToApplication < ActiveRecord::Migration[5.2]
  def change
    add_reference :applications, :original_application, index: true
  end
end
