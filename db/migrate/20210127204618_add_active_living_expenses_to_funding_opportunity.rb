class AddActiveLivingExpensesToFundingOpportunity < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_opportunities, :active_living_expenses, :boolean, default: false
  end
end
