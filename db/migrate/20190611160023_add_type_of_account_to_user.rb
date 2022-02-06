class AddTypeOfAccountToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :type_of_account, :string
  end
end
