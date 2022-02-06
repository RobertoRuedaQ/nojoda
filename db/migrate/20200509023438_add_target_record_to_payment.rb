class AddTargetRecordToPayment < ActiveRecord::Migration[5.2]
  def change
    add_reference :payments, :target_record, index: true
  end
end
