class CreateFundingOpportunities < ActiveRecord::Migration[5.2]
  def change
    create_table :funding_opportunities do |t|
      t.string :name
      t.references :fund, foreign_key: true
      t.boolean :field_work_required
      t.integer :available_places
      t.string :status
      t.date :start_date
      t.date :close_date
      t.decimal :budget
      t.string :opportunity_type
      t.references :signer, index: true
      t.references :eligibility_criteria, index: true
      

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated


      t.timestamps
    end
  end
end
