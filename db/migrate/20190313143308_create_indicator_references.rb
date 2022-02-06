class CreateIndicatorReferences < ActiveRecord::Migration[5.2]
  def change
    create_table :indicator_references do |t|
      t.string :model
      t.string :field
      t.string :filter
      t.string :operator
      t.references :indicator_case, foreign_key: true

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      

      t.timestamps
    end
  end
end
