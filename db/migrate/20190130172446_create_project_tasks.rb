class CreateProjectTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :project_tasks do |t|
      t.text :title, index:true
      t.datetime :done_date, index:true
      t.boolean :done, index:true,default: false
      t.text :description
      t.date :deadline, index:true
      t.references :responsable, index: true
      t.references :created_by, index:true
      t.references :project_task_type, foreign_key: true
      t.boolean :archived, index:true, default: false
      t.references :project_card, foreign_key: true
      t.integer :position
      t.references :parent, index:true
      t.boolean :locked, index:true, default: false
      t.references :company, foreign_key: true

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      

      t.timestamps
    end
  end
end
