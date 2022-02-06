class AddOtherPhoneToReference < ActiveRecord::Migration[5.2]
  def change
    add_column :references, :other_phone, :string
  end
end
