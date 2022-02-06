class AddPenaltyToPaymentConfig < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_configs, :penalty_case, :string
    add_column :payment_configs, :nominal_penalty, :float
    remove_column :funding_opportunities, :penalty_case, :string
    remove_column :funding_opportunities, :nominal_penalty, :float
  end
end
