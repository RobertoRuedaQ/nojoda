class AddIndexToUserTypeOfAccount < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :type_of_account
  end
end
