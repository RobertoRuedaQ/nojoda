class AddBootcampToFundingOpportunity < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_opportunities, :bootcamp, :boolean
  end
end
