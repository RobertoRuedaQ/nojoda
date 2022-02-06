class CreateCommunicationTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :communication_templates do |t|
      t.string :title
      t.string :subject
      t.text :body
      t.references :company, foreign_key: true
      t.references :communication_header, foreign_key: true
      t.references :communication_footer, foreign_key: true
      t.string :language, index:true
      t.references :communication_case, foreign_key: true
      t.string :status, index:true


      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      

      t.timestamps
    end
  end
end
