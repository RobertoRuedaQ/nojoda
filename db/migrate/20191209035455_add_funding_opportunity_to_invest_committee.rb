class AddFundingOpportunityToInvestCommittee < ActiveRecord::Migration[5.2]
  def change
    add_reference :invest_committees, :funding_opportunity, foreign_key: true
  end
end
