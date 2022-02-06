class CreateApplicationFollowUps < ActiveRecord::Migration[5.2]
  def change
    return if ActiveRecord::Base.connection.data_source_exists? 'application_follow_ups'

    create_table :application_follow_ups do |t|
      t.string :stage
      t.integer :order, default: 0
      t.references :application, foreign_key: true

      t.timestamps
    end
  end
end
