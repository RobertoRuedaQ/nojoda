class AddFundingOpportunityToFundingDisbursement < ActiveRecord::Migration[5.2]
  def change
    add_reference :funding_disbursements, :funding_opportunity, foreign_key: true
  end
end
