class RemoveFundingTeamTable < ActiveRecord::Migration[5.2]
  def change
  	drop_table :funding_teams, if_exists: true
  end
end
