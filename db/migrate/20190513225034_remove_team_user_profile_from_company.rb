class RemoveTeamUserProfileFromCompany < ActiveRecord::Migration[5.2]
  def change
  	remove_column :companies, :team_profile_id
  end
end
