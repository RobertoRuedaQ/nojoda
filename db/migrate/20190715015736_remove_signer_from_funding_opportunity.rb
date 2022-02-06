class RemoveSignerFromFundingOpportunity < ActiveRecord::Migration[5.2]
  def change
    remove_reference :funding_opportunities, :signer, index: true
  end
end
