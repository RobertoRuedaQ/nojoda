class AddEmergencyLivingExpensesOriginationToDisbursementOrigination < ActiveRecord::Migration[5.2]
  def change
    add_column :disbursement_originations, :emergency_living_expenses_origination_id, :integer
  end
end
