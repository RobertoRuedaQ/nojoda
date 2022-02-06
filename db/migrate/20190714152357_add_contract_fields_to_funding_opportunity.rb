class AddContractFieldsToFundingOpportunity < ActiveRecord::Migration[5.2]
  def change
    add_reference :funding_opportunities, :contract_adult, index: true
    add_reference :funding_opportunities, :contract_young, index: true
    add_reference :funding_opportunities, :contract_amend, index: true
  end
end
