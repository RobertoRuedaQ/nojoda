class ChangeOrderToOriginationModule < ActiveRecord::Migration[5.2]
  def change
  		change_column :origination_modules, :order, 'float USING CAST(origination_modules.order AS float)'
  end
end
