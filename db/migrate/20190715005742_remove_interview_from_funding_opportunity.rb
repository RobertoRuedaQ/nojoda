class RemoveInterviewFromFundingOpportunity < ActiveRecord::Migration[5.2]
  def change
    remove_reference :funding_opportunities, :interview, index: true
  end
end
