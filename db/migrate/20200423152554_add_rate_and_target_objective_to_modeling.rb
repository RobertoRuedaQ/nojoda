class AddRateAndTargetObjectiveToModeling < ActiveRecord::Migration[5.2]
  def change
    add_column :modelings, :target_rate, :float
    add_column :modelings, :target_case, :string
  end
end
