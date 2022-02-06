class AddStoredGeneralStatusToDisbursement < ActiveRecord::Migration[5.2]
  def change
    add_column :disbursements, :stored_general_status, :string
  end
end
