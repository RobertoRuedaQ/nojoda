class AddApplicationToLegalMatch < ActiveRecord::Migration[5.2]
  def change
    add_reference :legal_matches, :application, foreign_key: true
  end
end
