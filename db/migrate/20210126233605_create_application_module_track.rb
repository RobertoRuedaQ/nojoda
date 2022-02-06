class CreateApplicationModuleTrack < ActiveRecord::Migration[5.2]
  def change
    create_table :application_module_tracks do |t|
      t.references :application, foreign_key: true
      t.references :origination_module, foreign_key: true

      t.datetime :discarded_at,       index: true

      t.timestamps
    end
  end
end
