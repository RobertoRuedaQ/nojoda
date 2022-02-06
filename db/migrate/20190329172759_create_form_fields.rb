class CreateFormFields < ActiveRecord::Migration[5.2]
  def change
    create_table :form_fields do |t|
      t.string :name
      t.string :status
      t.integer :order
      t.integer :row
      t.integer :grid
      t.references :form_template, index:true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end
    add_index :form_fields, :name
    add_index :form_fields, :status
    add_index :form_fields, :order
    add_index :form_fields, :row
    add_index :form_fields, :grid
  end
end
