class AddFundToPaymentMassDoc < ActiveRecord::Migration[5.2]
  def change
    add_column :payment_mass_docs, :fund_name, :string
    add_reference :payment_mass_docs, :fund, foreign_key: true
  end
end
