class AddOriginationFieldsToFund < ActiveRecord::Migration[5.2]
  def change
    add_column :funds, :student_location_origination, :integer
    add_column :funds, :student_personal_information_origination, :integer
    add_column :funds, :student_contact_information_origination, :integer
    add_column :funds, :user_data_origination, :integer
  end
end
