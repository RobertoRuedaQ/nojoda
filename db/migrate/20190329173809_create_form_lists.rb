class CreateFormLists < ActiveRecord::Migration[5.2]
  def change
    create_table :form_lists do |t|
      t.string :case, index: true, unique: true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end
  end
end
