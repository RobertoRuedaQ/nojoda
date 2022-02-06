class AddTuitionVariablesToDisbursementRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :disbursement_requests, :tuition_funded_percentage, :float
    add_column :disbursement_requests, :disbursement_value, :float
  end
end
