class AddUserToFundingToken < ActiveRecord::Migration[5.2]
  def change
    add_reference :funding_tokens, :user, foreign_key: true
  end
end
