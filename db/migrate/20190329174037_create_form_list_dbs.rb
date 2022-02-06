class CreateFormListDbs < ActiveRecord::Migration[5.2]
  def change
    create_table :form_list_dbs do |t|
      t.references :form_list, foreign_key: true
      t.string :functionality

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end
  end
end
