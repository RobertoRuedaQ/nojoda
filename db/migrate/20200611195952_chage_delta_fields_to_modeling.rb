class ChageDeltaFieldsToModeling < ActiveRecord::Migration[5.2]
  def change
  	change_column :modelings, :delta_default, :float, default: 0
  	change_column :modelings, :delta_dropout, :float, default: 0
  	change_column :modelings, :delta_unemployment, :float, default: 0
  end
end
