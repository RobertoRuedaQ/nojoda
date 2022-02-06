class AddCreditCheckDisclosureToCompany < ActiveRecord::Migration[5.2]
  def change
    add_reference :companies, :credit_check_disclosure, index:true
  end
end
