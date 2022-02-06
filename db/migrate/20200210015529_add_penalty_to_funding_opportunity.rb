class AddPenaltyToFundingOpportunity < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_opportunities, :penalty_case, :string
    add_column :funding_opportunities, :nominal_penalty, :float
  end
end
