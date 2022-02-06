class ChangeValueFromPayment < ActiveRecord::Migration[5.2]
  def change
	change_column :payments, :value, 'float USING CAST(value AS float)'
  end
end
