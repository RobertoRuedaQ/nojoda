class AddRequestLivingExpensesToDisbursementRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :disbursement_requests, :living_expenses_check, :boolean
    add_column :disbursement_requests, :living_expenses_value, :float
  end
end
