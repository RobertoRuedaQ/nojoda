class AddConfirmedValueToDisbursementRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :disbursement_requests, :confirmed_value, :float
  end
end
