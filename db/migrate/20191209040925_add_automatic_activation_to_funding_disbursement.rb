class AddAutomaticActivationToFundingDisbursement < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_disbursements, :automatic_activation, :boolean
  end
end
