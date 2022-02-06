class AddFundingOpportunityToDisbursementOrigination < ActiveRecord::Migration[5.2]
  def change
    add_reference :disbursement_originations, :funding_opportunity, foreign_key: true
  end
end
