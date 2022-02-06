class AddFieldsToFundingOpportunity < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_opportunities, :show_tuition_table, :boolean, default: true
    add_column :funding_opportunities, :show_living_expenses_table, :boolean, default: true
  end
end
