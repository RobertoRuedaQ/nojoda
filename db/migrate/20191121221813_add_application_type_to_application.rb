class AddApplicationTypeToApplication < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :application_case, :string
  end
end
