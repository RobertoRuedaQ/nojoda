class CreateIndicatorInputs < ActiveRecord::Migration[5.2]
  def change
    create_table :indicator_inputs do |t|
      t.references :source, index: true
      t.references :destination, index: true
      t.references :indicator_case, foreign_key: true

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      

      t.timestamps
    end
  end
end
