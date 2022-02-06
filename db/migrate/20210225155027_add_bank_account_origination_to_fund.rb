class AddBankAccountOriginationToFund < ActiveRecord::Migration[5.2]
  def change
    add_column :funds, :bank_account_origination_id, :integer
  end
end
