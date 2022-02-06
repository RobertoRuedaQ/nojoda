class AddTransactionDetailToPayuTransaction < ActiveRecord::Migration[5.2]
  def change
    add_column :payu_transactions, :detail, :text
  end
end
