# This migration comes from approval_engine (originally 20180409000000)
class CreateApprovalTables < ActiveRecord::Migration[5.0]
  def change
    create_table :approval_requests do |t|
      t.integer  :request_user_id, null: false
      t.integer  :respond_user_id
      t.integer  :state,           null: false, limit: 1, default: 0
      t.datetime :requested_at,    null: false
      t.datetime :cancelled_at
      t.datetime :approved_at
      t.datetime :rejected_at
      t.datetime :executed_at

      ## Additional Fields
      t.integer :supervisor_id,   index:true

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

      t.timestamps

      t.index :request_user_id
      t.index :respond_user_id
      t.index :state

    end

    create_table :approval_items do |t|
      t.integer :request_id,    null: false
      t.integer :resource_id
      t.string  :resource_type, null: false
      t.string  :event,         null: false
      t.text    :params

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

      t.timestamps

      t.index :request_id
      t.index [:resource_id, :resource_type]
    end

    create_table :approval_comments do |t|
      t.integer :request_id, null: false
      t.integer :user_id,    null: false
      t.text    :content,    null: false

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

      t.timestamps

      t.index :request_id
      t.index :user_id
    end
  end
end
