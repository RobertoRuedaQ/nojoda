class RemoveContractAmendFromFundingOpportunity < ActiveRecord::Migration[5.2]
  def change
    remove_reference :funding_opportunities, :contract_amend, index: true
  end
end
