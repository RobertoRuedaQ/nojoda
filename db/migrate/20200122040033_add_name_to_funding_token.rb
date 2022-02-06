class AddNameToFundingToken < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_tokens, :name, :string
  end
end
