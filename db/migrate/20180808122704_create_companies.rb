class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name, index: true,unique: true, null: false
      t.references :company, foreign_key: true
      t.references :country,foreign_key: true
      t.string :status, status: true,null: false
      t.string :url, index: true,unique: true,null: false
      t.string :default_language, index:true, null: false
      t.string :timezone, index:true, null: false
      t.string :main_title
      t.string :slogan

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      

      t.timestamps
    end
  end
end
