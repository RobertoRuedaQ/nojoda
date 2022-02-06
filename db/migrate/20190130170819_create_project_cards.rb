class CreateProjectCards < ActiveRecord::Migration[5.2]
  def change
    create_table :project_cards do |t|
      t.string :title
      t.integer :position
      t.references :project, foreign_key: true

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      

      t.timestamps
    end
  end
end
