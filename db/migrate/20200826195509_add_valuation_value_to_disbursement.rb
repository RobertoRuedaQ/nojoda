class AddValuationValueToDisbursement < ActiveRecord::Migration[5.2]
  def change
    add_column :disbursements, :valuation_value, :float
  end
end
