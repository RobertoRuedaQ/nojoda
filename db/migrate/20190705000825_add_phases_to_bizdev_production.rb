class AddPhasesToBizdevProduction < ActiveRecord::Migration[5.2]
  def change
    add_column :bizdev_operations, :technology_phase, :string
    add_column :bizdev_operations, :operations_phase, :string
    add_column :bizdev_operations, :legal_phase, :string
    add_column :bizdev_operations, :research_phase, :string
    add_column :bizdev_operations, :financial_phase, :string
  end
end
