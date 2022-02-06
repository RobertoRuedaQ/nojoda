class AddCachedValuesToDisbursement < ActiveRecord::Migration[5.2]
  def change
    add_column :disbursements, :requested, :float
    add_column :disbursements, :approved, :float
    add_column :disbursements, :compromised, :float
    add_column :disbursements, :disbursed, :float
    add_column :disbursements, :disbursement_process, :float
  end
end
