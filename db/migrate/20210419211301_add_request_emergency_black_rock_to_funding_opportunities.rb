class AddRequestEmergencyBlackRockToFundingOpportunities < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_opportunities, :emergency_black_rock, :boolean, default: false
  end
end
