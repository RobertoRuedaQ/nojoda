class AddIdentificationNumberToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :identification_number, :string
  end
end
