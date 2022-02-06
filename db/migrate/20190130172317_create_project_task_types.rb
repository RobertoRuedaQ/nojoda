class CreateProjectTaskTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :project_task_types do |t|
      t.string :title, index:true
      t.text :description
      t.string :functionality
      t.boolean :free_promotion, index:true, default: true
      t.boolean :multilanguage, index:true, default:true

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      

      t.timestamps
    end
  end
end
