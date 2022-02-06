class AddDynamicRateCapToFundingOpportunity < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_opportunities, :dynamic_rate_cap, :boolean, default: false
  end
end
