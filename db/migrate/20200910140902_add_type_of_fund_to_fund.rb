class AddTypeOfFundToFund < ActiveRecord::Migration[5.2]
  def change
    add_column :funds, :type_of_fund, :string
  end
end
