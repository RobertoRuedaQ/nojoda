class AddVariablesToInvestCommittee < ActiveRecord::Migration[5.2]
  def change
    add_column :invest_committees, :notes, :text
    add_column :invest_committees, :status, :string
    add_reference :invest_committees, :company, foreign_key: true
  end
end
