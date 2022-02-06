class AddFieldsToDisbrusementRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :disbursement_requests, :reimbursement_value, :float
  end
end
