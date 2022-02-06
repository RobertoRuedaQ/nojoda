class AddStudentFinancialInformationOriginationToFund < ActiveRecord::Migration[5.2]
  def change
    add_reference :funds, :student_financial_information_origination, index: true
  end
end
