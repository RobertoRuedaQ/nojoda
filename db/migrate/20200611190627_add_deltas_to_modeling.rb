class AddDeltasToModeling < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :delta_default, :float
    add_column :modelings, :delta_dropout, :float
    add_column :modelings, :delta_unemployment, :float
  end
end
