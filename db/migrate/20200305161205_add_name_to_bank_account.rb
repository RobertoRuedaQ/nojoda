class AddNameToBankAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :bank_accounts, :name, :string
  end
end
