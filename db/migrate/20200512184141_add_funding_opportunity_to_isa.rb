class AddFundingOpportunityToIsa < ActiveRecord::Migration[5.2]
  def change
    add_reference :isas, :funding_opportunity, foreign_key: true
  end
end
