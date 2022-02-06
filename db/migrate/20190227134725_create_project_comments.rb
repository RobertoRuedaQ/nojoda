class CreateProjectComments < ActiveRecord::Migration[5.2]
  def change
    create_table :project_comments do |t|
      t.text :comment
      t.references :project_task, foreign_key: true
      t.references :user, foreign_key: true

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      

      t.timestamps
    end
  end
end
