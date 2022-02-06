class AdddPromissoryNoteLegalMatchToSignioRecord < ActiveRecord::Migration[5.2]
  def change
    add_column :signio_records, :promissory_note_legal_match_id, :integer
  end
end
