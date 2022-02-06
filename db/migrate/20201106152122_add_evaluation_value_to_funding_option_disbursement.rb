class AddEvaluationValueToFundingOptionDisbursement < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_option_disbursements, :evaluation_value, :float
  end
end
