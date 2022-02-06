class CreateFormAttributes < ActiveRecord::Migration[5.2]
  def change
    create_table :form_attributes do |t|
      t.string :name
      t.string :value
      t.references :form_field, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end
  end
end
