class ChangeDateToValuationHistory < ActiveRecord::Migration[5.2]
  def change
  	change_column :valuation_histories, :date, :datetime
  end
end
