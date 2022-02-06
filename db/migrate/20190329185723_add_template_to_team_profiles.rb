class AddTemplateToTeamProfiles < ActiveRecord::Migration[5.2]
  def change
    add_reference :team_profiles, :form_template, foreign_key: true
  end
end
