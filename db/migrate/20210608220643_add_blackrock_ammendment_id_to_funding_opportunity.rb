class AddBlackrockAmmendmentIdToFundingOpportunity < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_opportunities, :blackrock_ammendment_id, :integer
  end
end
