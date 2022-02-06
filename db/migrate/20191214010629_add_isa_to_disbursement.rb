class AddIsaToDisbursement < ActiveRecord::Migration[5.2]
  def change
    add_reference :disbursements, :isa, foreign_key: true
  end
end
