class AddMexicoFieldsToStudentFinancialInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :student_financial_informations, :billing_owner_rfc, :string
    add_column :student_financial_informations, :billing_owner_first_name, :string
    add_column :student_financial_informations, :billing_owner_middle_name, :string
    add_column :student_financial_informations, :billing_owner_last_name, :string
    add_column :student_financial_informations, :billing_owner_bussiness_name, :string
    add_column :student_financial_informations, :billing_owner_email, :string
    add_column :student_financial_informations, :billing_owner_address, :string
  end
end
