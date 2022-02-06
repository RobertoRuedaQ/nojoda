class AddInviteTemplateToFundingOpportunity < ActiveRecord::Migration[5.2]
  def change
    add_reference :funding_opportunities, :invite_template, index: true
  end
end
