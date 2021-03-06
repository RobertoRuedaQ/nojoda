# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      ## Lumni user fields
      t.string :first_name,          null: false
      t.string :middle_name
      t.string :last_name,           null: false
      t.string :status,              null: false, default: 'active'
      t.references :user_profile, polymorphic: true, index: true
      t.string :language,            null: false, default: 'en'
      t.string :time_zone,           null: false, default: 'Bogota'
      t.boolean :test_account,       null: false, default: false
      t.references :company, foreign_key: true
      t.boolean :student_account,     null: false, default: true
      t.references :supervisor,     index: true 



      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated,            default: false
      

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true

    ## Additional indexes

    add_index :users, :first_name
    add_index :users, :last_name

    ## Default Lumni indexes
    add_index :users, :migrated




  end
end
