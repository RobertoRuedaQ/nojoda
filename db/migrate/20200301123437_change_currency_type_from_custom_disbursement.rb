class ChangeCurrencyTypeFromCustomDisbursement < ActiveRecord::Migration[5.2]
  def change
  	change_column :custom_disbursements, :currency, :string
  end
end
