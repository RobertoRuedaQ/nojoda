class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :name, index: true
      t.decimal :yearly_usury_rate
      t.integer :round_up_to
      t.string :currency

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated

      t.timestamps
    end
  end
end
