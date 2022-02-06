class AddBlackRockOriginationToFund < ActiveRecord::Migration[5.2]
  def change
    add_column :funds, :black_rock_origination_id, :integer
  end
end
