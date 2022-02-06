class AddIncomePercentileToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :income_percentile, :string, default: 'p50'
  end
end
