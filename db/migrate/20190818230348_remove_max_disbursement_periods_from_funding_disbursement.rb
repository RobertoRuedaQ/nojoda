class RemoveMaxDisbursementPeriodsFromFundingDisbursement < ActiveRecord::Migration[5.2]
  def change
    remove_column :funding_disbursements, :max_disbursement_periods, :integer
  end
end
