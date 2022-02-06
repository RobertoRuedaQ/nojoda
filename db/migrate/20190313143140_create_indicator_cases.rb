class CreateIndicatorCases < ActiveRecord::Migration[5.2]
  def change
    create_table :indicator_cases do |t|
      t.string :name
      t.string :status
      t.references :company, foreign_key: true
      t.references :indicator_type, foreign_key: true
      t.string :function

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      


      t.timestamps
    end
  end
end
