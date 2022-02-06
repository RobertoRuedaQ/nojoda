class AddStatusToLegalMatch < ActiveRecord::Migration[5.2]
  def change
    add_column :legal_matches, :status, :string
  end
end
