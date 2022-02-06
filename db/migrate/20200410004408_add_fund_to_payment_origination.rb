class AddFundToPaymentOrigination < ActiveRecord::Migration[5.2]
  def change
    add_reference :payment_originations, :fund, foreign_key: true
  end
end
