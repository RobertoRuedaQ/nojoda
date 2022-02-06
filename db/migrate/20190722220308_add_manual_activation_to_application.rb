class AddManualActivationToApplication < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :manual_activation, :boolean, default: false
  end
end
