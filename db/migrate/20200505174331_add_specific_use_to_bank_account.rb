class AddSpecificUseToBankAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :bank_accounts, :specific_use, :string
  end
end
