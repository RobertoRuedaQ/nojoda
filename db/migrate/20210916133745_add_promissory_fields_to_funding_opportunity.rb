class AddPromissoryFieldsToFundingOpportunity < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_opportunities, :include_promissory_note, :boolean, default: false
    add_column :funding_opportunities, :promissory_note_id, :integer
  end
end
