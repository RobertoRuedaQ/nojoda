class AddInterviewToFundingOpportunity < ActiveRecord::Migration[5.2]
  def change
    add_reference :funding_opportunities, :interview, index: true
  end
end
