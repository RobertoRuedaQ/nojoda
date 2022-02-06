class AddDefaultLumniFieldsToTeamProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :team_profiles, :external_id, :string
    add_index :team_profiles, :external_id
    add_column :team_profiles, :discarded_at, :datetime
    add_index :team_profiles, :discarded_at
    add_column :team_profiles, :migrated, :boolean
  end
end
