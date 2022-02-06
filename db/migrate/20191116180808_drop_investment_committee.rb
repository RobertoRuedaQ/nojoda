class DropInvestmentCommittee < ActiveRecord::Migration[5.2]
  def change
  	drop_table :investment_committees, if_exists: true
  end
end
