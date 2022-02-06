class AddRfcToPersonalReference < ActiveRecord::Migration[5.2]
  def change
    add_column :references, :rfc, :string
  end
end
