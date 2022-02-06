class RemoveContractFromFundingOpportunity < ActiveRecord::Migration[5.2]
  def change
    remove_reference :funding_opportunities, :contract, index: true
    remove_reference :funding_opportunities, :amendment, index: true
  end
end
