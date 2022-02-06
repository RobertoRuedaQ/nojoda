class AddCacheFundingOptionVariablesToIsa < ActiveRecord::Migration[5.2]
  def change
    add_column :isas, :repayment_total_number, :float
    add_column :isas, :repayment_payed_number, :float
    add_column :isas, :payment_to_finalize_isa, :float
  end
end
