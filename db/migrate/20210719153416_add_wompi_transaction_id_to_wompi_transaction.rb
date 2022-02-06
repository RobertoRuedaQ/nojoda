class AddWompiTransactionIdToWompiTransaction < ActiveRecord::Migration[5.2]
  def change
    add_column :wompi_transactions, :wompi_transaction_id, :string, default: ''
  end
end
