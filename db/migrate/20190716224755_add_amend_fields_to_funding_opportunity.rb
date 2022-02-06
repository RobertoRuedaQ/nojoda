class AddAmendFieldsToFundingOpportunity < ActiveRecord::Migration[5.2]
  def change
    add_reference :funding_opportunities, :amendment_young, index: true
    add_reference :funding_opportunities, :amendment_adult, index: true
  end
end
