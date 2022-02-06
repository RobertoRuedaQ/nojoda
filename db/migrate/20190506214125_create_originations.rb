class CreateOriginations < ActiveRecord::Migration[5.2]
  def change
    create_table :originations do |t|
      t.string :name
      t.string :status

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end
  end
end
