class AddGeneralStatusToIsa < ActiveRecord::Migration[5.2]
  def change
    add_column :isas, :stored_income_status, :string
    add_column :isas, :stored_payment_status, :string
    add_column :isas, :stored_general_status, :string
  end
end
