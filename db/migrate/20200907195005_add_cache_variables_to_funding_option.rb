class AddCacheVariablesToFundingOption < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_options, :total_pending_disbursement, :float
    add_column :funding_options, :total_payed_disbursement, :float
    add_column :funding_options, :total_approved_disbursement, :float
  end
end
