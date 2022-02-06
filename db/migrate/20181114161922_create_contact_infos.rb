class CreateContactInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :contact_infos do |t|

      t.string :area_code
      t.string :phone
      t.integer :extension_number
      t.string :mobile
      t.string :other_phone
      t.string :email
      t.string :secondary_email
      t.references :resource, polymorphic: true, index: true

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

      t.timestamps
    end
  end
end
