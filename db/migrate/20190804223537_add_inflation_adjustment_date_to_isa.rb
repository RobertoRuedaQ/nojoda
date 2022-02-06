class AddInflationAdjustmentDateToIsa < ActiveRecord::Migration[5.2]
  def change
    add_column :isas, :inflation_case, :string
    add_column :isas, :inflation_adjustment_date, :date
  end
end
