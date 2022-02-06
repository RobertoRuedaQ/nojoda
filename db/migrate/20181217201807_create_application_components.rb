class CreateApplicationComponents < ActiveRecord::Migration[5.2]
  def change
    create_table :application_components do |t|
      t.references :funding_opportunity, foreign_key: true
      t.references :reference, polymorphic: true, index: true
      t.string :process, index: true, null: true

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

      t.timestamps
    end
  end
end
