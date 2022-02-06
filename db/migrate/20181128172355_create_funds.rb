class CreateFunds < ActiveRecord::Migration[5.2]
  def change
    create_table :funds do |t|
      t.string :name,  index: true, unique: true
      t.references :fund, foreign_key: true
      t.boolean :preapproval_by_investor
      t.float :renewal_in_years
      t.boolean :active
      t.boolean :applies_taxes
      t.integer :close_day
      t.integer :timely_payment_day
      t.date :start_date
      t.date :close_date
      t.integer :extension_periods
      t.references :company, foreign_key: true

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

      t.timestamps
    end


  end
end
