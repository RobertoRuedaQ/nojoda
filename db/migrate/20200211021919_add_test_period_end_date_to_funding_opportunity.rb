class AddTestPeriodEndDateToFundingOpportunity < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_opportunities, :test_period_end_date, :date
  end
end
