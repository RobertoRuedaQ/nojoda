class CreateEligibilityUsas < ActiveRecord::Migration[5.2]
  def change
    create_table :eligibility_usas do |t|
      t.string :academic_year
      t.boolean :fafsa
      t.string :citizenship
      t.boolean :preaproved
      t.string :study_status
      t.float :estimated_assistance
      t.float :cost_attendance
      t.references :application, foreign_key: true

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

      t.timestamps
    end
  end
end
