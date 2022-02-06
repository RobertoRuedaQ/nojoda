class AddConservativeSalariesToFund < ActiveRecord::Migration[5.2]
  def change
    add_column :funds, :conservative_salaries, :boolean
  end
end
