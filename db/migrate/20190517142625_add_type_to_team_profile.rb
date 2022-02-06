class AddTypeToTeamProfile < ActiveRecord::Migration[5.2]
  def change
    add_column :team_profiles, :action, :string, null: false, default: 'custom'
  end
end
