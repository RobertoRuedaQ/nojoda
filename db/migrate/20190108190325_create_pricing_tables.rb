class CreatePricingTables < ActiveRecord::Migration[5.2]
  def change
    create_table :pricing_tables do |t|
      t.references :institutions, foreign_key: true
      t.references :funding_opportunities, foreign_key: true
      t.string :grade_level, index:true
      t.string :cluster, index:true
      t.integer :isa_length
      t.float :real_cap
      t.float :reference_value
      t.string :periodicity

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      

      t.timestamps
    end
  end
end
