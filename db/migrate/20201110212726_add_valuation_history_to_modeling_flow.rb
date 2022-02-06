class AddValuationHistoryToModelingFlow < ActiveRecord::Migration[5.2]
  def change
    add_reference :modeling_flows, :valuation_history, foreign_key: true
  end
end
