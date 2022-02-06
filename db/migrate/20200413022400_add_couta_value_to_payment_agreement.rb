class AddCoutaValueToPaymentAgreement < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_agreements, :cuota_value, :float
  end
end
