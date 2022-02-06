class RemoveDetailFromPayuTransaction < ActiveRecord::Migration[5.2]
  def change
    remove_column :payu_transactions, :detail, :text
  end
end
