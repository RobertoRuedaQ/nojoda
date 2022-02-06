class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :result
      t.string :status
      t.string :decision
      t.string :score
      t.boolean :show_financial_proposals
      t.references :user, foreign_key: true
      t.references :funding_opportunity, foreign_key: true
      t.boolean :fulfill_requirements
      t.integer :step
      t.boolean :eligibility_criteria_match
      




      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

      t.timestamps
    end
  end
end
