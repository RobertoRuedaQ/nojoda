class AddConciliationToFund < ActiveRecord::Migration[5.2]
  def change
    add_column :funds, :conciliation, :boolean
  end
end
