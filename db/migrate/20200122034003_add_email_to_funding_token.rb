class AddEmailToFundingToken < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_tokens, :email_sent, :boolean
    add_column :funding_tokens, :target_email, :string
  end
end
