class AddHurdleTaxesToFund < ActiveRecord::Migration[5.2]
  def change
    add_column :funds, :hurdle_taxes, :boolean
  end
end
