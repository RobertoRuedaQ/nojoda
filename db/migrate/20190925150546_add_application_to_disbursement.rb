class AddApplicationToDisbursement < ActiveRecord::Migration[5.2]
  def change
    add_reference :disbursements, :application, foreign_key: true
  end
end
