class CreateApprovalMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :approval_matches do |t|
      t.references :user, foreign_key: true
      t.references :role, index: true
      t.references :approver, index:true
      t.string :approver_role, index:true

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

      t.timestamps
    end
  end
end
