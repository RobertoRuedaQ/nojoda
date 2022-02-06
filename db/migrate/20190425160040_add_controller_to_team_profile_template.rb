class AddControllerToTeamProfileTemplate < ActiveRecord::Migration[5.2]
  def change
    add_column :team_profile_templates, :controller_name, :string
  end
end
