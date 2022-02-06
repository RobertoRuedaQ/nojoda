class AddFundWithdrawalToFund < ActiveRecord::Migration[5.2]
  def change
    add_column :funds, :fund_withdrawal_origination_id, :integer
  end
end
