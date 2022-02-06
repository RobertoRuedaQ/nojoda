class AddOfferDueDateToFundingOpportunity < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_opportunities, :offer_validity_days, :integer
    add_column :funding_opportunities, :cancellation_days, :integer
  end
end
