class AddMinConciliationToFund < ActiveRecord::Migration[5.2]
  def change
    add_column :funds, :min_conciliation, :float
  end
end
