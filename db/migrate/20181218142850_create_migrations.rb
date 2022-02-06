class CreateMigrations < ActiveRecord::Migration[5.2]
  def change
    create_table :migrations do |t|
      t.string :fund
      t.string :result
      t.string :notes
      t.references :company, foreign_key: true
      t.string :new_fund_name

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

      t.timestamps
    end
  end
end
