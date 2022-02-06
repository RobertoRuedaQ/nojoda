class AddApplicationToFundingOption < ActiveRecord::Migration[5.2]
  def change
    add_reference :funding_options, :application, foreign_key: true
  end
end
