class RenameColumnToFundingOpportunity < ActiveRecord::Migration[5.2]
  def change
    rename_column :funding_opportunities, :promissory_note_id, :adult_promissory_note_id
  end
end
