class ChangeDoYouUseBankingServiceAtStudentFinancialInformation < ActiveRecord::Migration[5.2]
  def change
  	change_column :student_financial_informations, :do_you_use_banking_service, :string
  end
end
