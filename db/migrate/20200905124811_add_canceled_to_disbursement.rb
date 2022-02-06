class AddCanceledToDisbursement < ActiveRecord::Migration[5.2]
  def change
    add_column :disbursements, :canceled, :float
  end
end
