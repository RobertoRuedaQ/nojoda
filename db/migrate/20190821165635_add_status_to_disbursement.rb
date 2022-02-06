class AddStatusToDisbursement < ActiveRecord::Migration[5.2]
  def change
    add_column :disbursements, :status, :string
  end
end
