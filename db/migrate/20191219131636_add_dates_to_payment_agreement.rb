class AddDatesToPaymentAgreement < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_agreements, :start_date, :date
    add_column :payment_agreements, :end_date, :date
  end
end
