class CreateTeamSupervisors < ActiveRecord::Migration[5.2]
  def change
    create_table :team_supervisors do |t|
      t.references :supervisor, index: true
      t.references :team_member, index: true

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      

      t.timestamps
    end
  end
end
