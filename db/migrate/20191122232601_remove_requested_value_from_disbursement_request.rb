class RemoveRequestedValueFromDisbursementRequest < ActiveRecord::Migration[5.2]
  def change
    remove_column :disbursement_requests, :requested_value, :float
  end
end
