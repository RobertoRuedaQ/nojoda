class AddTeamProfileToCompany < ActiveRecord::Migration[5.2]
  def change
    add_reference :companies, :team_profile, foreign_key: true
  end
end
