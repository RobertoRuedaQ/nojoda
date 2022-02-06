class CreateTeamProfileTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :team_profile_templates do |t|
      t.references :form_template, foreign_key: true
      t.references :team_profile, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end
  end
end
