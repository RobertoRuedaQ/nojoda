class AddBillingToSomeoneElse < ActiveRecord::Migration[5.2]
  def change
    add_column :student_financial_informations, :billing_to_someone_else, :boolean, default: false
  end
end
