class AddUniqRestrictionToPayment < ActiveRecord::Migration[5.2]
  def change
    add_index :payments, [:resource_id, :value, :resource_type, :billing_document_id], unique: true, name: 'uniq_payment'
  end
end
