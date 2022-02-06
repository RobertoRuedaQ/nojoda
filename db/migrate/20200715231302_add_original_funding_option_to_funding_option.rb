class AddOriginalFundingOptionToFundingOption < ActiveRecord::Migration[5.2]
  def change
    add_reference :funding_options, :original_option, index: true
  end
end
