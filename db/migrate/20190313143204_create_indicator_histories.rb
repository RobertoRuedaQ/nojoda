class CreateIndicatorHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :indicator_histories do |t|
      t.string :name
      t.decimal :value
      t.string :format
      t.date :date
      t.references :indicator_case, foreign_key: true


      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      

      t.timestamps
    end
  end
end
