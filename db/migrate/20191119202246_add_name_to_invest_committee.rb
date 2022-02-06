class AddNameToInvestCommittee < ActiveRecord::Migration[5.2]
  def change
    add_column :invest_committees, :name, :string
  end
end
