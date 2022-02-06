class CreateLegalMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :legal_matches do |t|
      t.references :user, foreign_key: true
      t.references :legal_document, foreign_key: true
      t.string :validation_method
      t.string :validation
      t.string :answer
      t.text :body


      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated


      t.timestamps
    end
  end
end
