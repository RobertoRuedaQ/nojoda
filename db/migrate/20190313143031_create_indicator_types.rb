class CreateIndicatorTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :indicator_types do |t|
      t.string :title
      t.text :description
      t.string :functionality
      t.string :status

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      

      t.timestamps
    end
  end
end
