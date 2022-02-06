class AddFundingTokenToCustomDisbursement < ActiveRecord::Migration[5.2]
  def change
    add_reference :custom_disbursements, :funding_token, foreign_key: true
  end
end
