class AddFullRoomToFundingOpportunity < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_opportunities, :full_room, :boolean, default: false
  end
end
