class AddTypologyToApplication < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :typology, :integer, default: 0
  end
end
