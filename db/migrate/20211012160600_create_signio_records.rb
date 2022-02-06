class CreateSignioRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :signio_records do |t|
      t.integer :legal_match_id
      t.references :user, foreign_key: true
      t.string :id_transaction, null:false
      t.string :id_contract_document, null:false
      t.string :id_promissory_document
      t.string :id_student_in_signio, null:false
      t.string :id_jointly_liable_in_signio
      t.string :id_legal_representative_in_signio
      t.string :id_zigma_representative_in_signio
      t.jsonb :tag_coordinates

      t.timestamps
    end
  end
end
