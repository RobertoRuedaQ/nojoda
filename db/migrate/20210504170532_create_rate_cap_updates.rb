class CreateRateCapUpdates < ActiveRecord::Migration[5.2]
  def change
    create_table :rate_cap_updates do |t|
      t.float :rate_cap_value
      t.integer :responsible_id

      t.timestamps
    end
  end
end
