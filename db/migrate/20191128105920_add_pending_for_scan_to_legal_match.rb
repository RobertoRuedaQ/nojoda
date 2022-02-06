class AddPendingForScanToLegalMatch < ActiveRecord::Migration[5.2]
  def change
    add_column :legal_matches, :pending_for_scan, :boolean
  end
end
