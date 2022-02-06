class CreateIndicatorRepetitions < ActiveRecord::Migration[5.2]
  def change
    create_table :indicator_repetitions do |t|
      t.string :day
      t.integer :time
			t.references :indicator_case, foreign_key: true

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      


      t.timestamps
    end
  end
end
