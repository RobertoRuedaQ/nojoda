class AddParentToLegalMatch < ActiveRecord::Migration[5.2]
  def change
    add_column :legal_matches, :parent_id, :integer
  end
end
