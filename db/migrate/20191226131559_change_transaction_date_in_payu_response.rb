class ChangeTransactionDateInPayuResponse < ActiveRecord::Migration[5.2]
  def change
  	change_column :payu_responses, :transaction_date, :string
  end
end
