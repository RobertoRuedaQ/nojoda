class AddRfcToPersonalInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :personal_informations, :rfc, :string
  end
end
