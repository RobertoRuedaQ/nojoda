class RemoveAreYouCurrentlyWorkingFromStudentFinancialInformation < ActiveRecord::Migration[5.2]
  def change
    remove_column :student_financial_informations, :are_you_currently_working, :boolean
  end
end
