class CreatePricingDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :pricing_details do |t|
      t.string :case
      t.decimal :min, index: true
      t.decimal :max, index: true
      t.decimal :percentage
      t.float :initial_income_cap
      t.float :cash_reserves_needed
      t.integer :exit_year
      t.references :pricing_table, foreign_key: true

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      

      t.timestamps
    end
    add_index :pricing_details, :case
  end
end
