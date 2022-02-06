class CreateMajors < ActiveRecord::Migration[5.2]
  def change
    create_table :majors do |t|
      t.string :name
      t.string :academic_level
      t.string :status
      t.references :institution, foreign_key: true

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      

      t.timestamps
    end
    add_index :majors, :name
    add_index :majors, :academic_level
    add_index :majors, :status
  end
end
