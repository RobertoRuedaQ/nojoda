class AddIncomeInformationToInfoTerpel < ActiveRecord::Migration[5.2]
  def change
    add_reference :info_terpels, :country_id, index: true
    add_reference :info_terpels, :city_id, index: true
    add_reference :info_terpels, :state_id, index: true
    add_column :info_terpels, :company_name, :string
    add_column :info_terpels, :position, :string
    add_column :info_terpels, :contract_case, :string
    add_column :info_terpels, :start_date, :date
    add_column :info_terpels, :fix_income, :float
    add_column :info_terpels, :end_date, :date
    add_column :info_terpels, :shift, :string
    add_column :info_terpels, :email_supervisor, :string
    add_column :info_terpels, :name_supervisor, :string
    add_column :info_terpels, :position_supervisor, :string
    add_column :info_terpels, :company_phone, :string
    add_column :info_terpels, :relationship, :string
  end
end
