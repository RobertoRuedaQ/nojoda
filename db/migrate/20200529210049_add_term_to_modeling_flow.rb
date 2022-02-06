class AddTermToModelingFlow < ActiveRecord::Migration[5.2]
  def change
    add_column :modeling_flows, :year, :integer
    add_column :modeling_flows, :month, :integer
  end
end
