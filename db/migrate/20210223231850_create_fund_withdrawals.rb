class CreateFundWithdrawals < ActiveRecord::Migration[5.2]
  def change
    create_table :fund_withdrawals do |t|
      t.string :reason
      t.text :description
      t.references :isa, foreign_key: true

      t.timestamps
    end
  end
end
