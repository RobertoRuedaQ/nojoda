class AddModelingToFundingOpportunity < ActiveRecord::Migration[5.2]
  def change
    add_reference :funding_opportunities, :modeling, foreign_key: true
  end
end
