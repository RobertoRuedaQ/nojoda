class CreateFormLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :form_labels do |t|
      t.string :label
      t.string :language
      t.references :resource, :polymorphic => true

            ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

t.timestamps
    end
    add_index :form_labels, :language
  end
end
