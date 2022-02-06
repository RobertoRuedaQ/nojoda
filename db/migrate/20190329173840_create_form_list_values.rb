class CreateFormListValues < ActiveRecord::Migration[5.2]
  def change
    create_table :form_list_values do |t|
      t.string :value
      t.references :form_list, foreign_key: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end
  end
end
