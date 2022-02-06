class CreateQuestionnaires < ActiveRecord::Migration[5.2]
  def change
    create_table :questionnaires do |t|
      t.string :name
      t.string :category
      t.references :parent, index:true
      t.float :max_score, default: 100
      t.integer :position
      t.float :min_approval_score, default: 60
      t.integer :time_limit
      t.float :weight, default: 100
      t.string :status
      t.integer :position


      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      

      t.timestamps
    end
  end
end
