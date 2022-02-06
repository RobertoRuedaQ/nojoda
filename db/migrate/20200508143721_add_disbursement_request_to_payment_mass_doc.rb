class AddDisbursementRequestToPaymentMassDoc < ActiveRecord::Migration[5.2]
  def change
    add_reference :payment_mass_docs, :disbursement_request, foreign_key: true
  end
end
