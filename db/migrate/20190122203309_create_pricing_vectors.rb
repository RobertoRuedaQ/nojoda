class CreatePricingVectors < ActiveRecord::Migration[5.2]
  def change
    create_table :pricing_vectors do |t|

      t.references :pricing_detail, foreign_key: true
      t.decimal :salary
      t.decimal :repayment
      t.decimal :service

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      

      t.timestamps
    end
  end
end
