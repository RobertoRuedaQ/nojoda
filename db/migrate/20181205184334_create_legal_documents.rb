class CreateLegalDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :legal_documents do |t|
      t.string :name, unique: true
      t.text :body
      t.string :document_type
      t.string :access
      t.string :status
      t.string :validation_method
      t.string :activation_method
      t.string :language
      t.references :legal_documents, foreign_key: true
      t.references :company, foreign_key: true


      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated


      t.timestamps
    end
  end
end
