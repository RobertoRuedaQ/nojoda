class AddMaxFundingMonthsToFundingDisbursement < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_disbursements, :max_funding_months, :integer
  end
end
