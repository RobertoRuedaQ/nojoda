class AddPaymentAgreementToConciliationInformation < ActiveRecord::Migration[5.2]
  def change
    add_reference :conciliation_informations, :payment_agreement, foreign_key: true
  end
end
