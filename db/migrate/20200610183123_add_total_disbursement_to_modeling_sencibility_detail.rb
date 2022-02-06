class AddTotalDisbursementToModelingSencibilityDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :modeling_sencibility_details, :total_disbursement, :float
    add_column :modeling_sencibility_details, :log_info, :text
  end
end
