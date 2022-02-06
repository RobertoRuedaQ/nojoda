class AddIncomeInformationToConciliationInformation < ActiveRecord::Migration[5.2]
  def change
    add_reference :conciliation_informations, :income_information, foreign_key: true
  end
end
