class AddNewAttributesToFund < ActiveRecord::Migration[5.2]
  def change
    add_column :funds, :vat_for_all_payments, :boolean
    add_column :funds, :min_student_irr_for_vat, :float
    add_column :funds, :escrow_monthly_cost, :float
    add_column :funds, :aum_fund, :float
    add_column :funds, :rate_fo_return_saving_account, :float
  end
end
