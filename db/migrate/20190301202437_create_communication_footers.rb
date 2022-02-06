class CreateCommunicationFooters < ActiveRecord::Migration[5.2]
  def change
    create_table :communication_footers do |t|
      t.string :title
      t.text :body
      t.references :company, foreign_key: true

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      

      t.timestamps
    end
  end
end
