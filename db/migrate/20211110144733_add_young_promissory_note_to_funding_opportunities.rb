class AddYoungPromissoryNoteToFundingOpportunities < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_opportunities, :young_promissory_note_id, :integer
  end
end
