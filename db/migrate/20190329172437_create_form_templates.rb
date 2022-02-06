class CreateFormTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :form_templates do |t|
      t.string :name, null: false
      t.string :object, null: false

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end
    add_index :form_templates, :name, unique: true
    add_index :form_templates, :object
  end
end
