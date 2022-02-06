class AddLivingExpensesToFundingDisbursement < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_disbursements, :living_expenses_value, :float
    add_column :funding_disbursements, :living_expenses_periodicity, :integer
    add_column :funding_disbursements, :max_tuition_percentage, :float
  end
end
