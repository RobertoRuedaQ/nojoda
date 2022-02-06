class AddIncomeVariablesToStudentFinancialInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :student_financial_informations, :other_people_value, :float
    add_column :student_financial_informations, :personal_business_value, :float
    add_column :student_financial_informations, :federal_aid_value, :float
    add_column :student_financial_informations, :temporal_work_value, :float
    add_column :student_financial_informations, :full_time_employ_value, :float
    add_column :student_financial_informations, :partial_time_employ_value, :float
    add_column :student_financial_informations, :other_people_frequency, :string
    add_column :student_financial_informations, :personal_business_frequency, :string
    add_column :student_financial_informations, :federal_aid_frequency, :string
    add_column :student_financial_informations, :temporal_work_frequency, :string
    add_column :student_financial_informations, :full_time_employ_frequency, :string
    add_column :student_financial_informations, :partial_time_employ_frequency, :string
  end
end
