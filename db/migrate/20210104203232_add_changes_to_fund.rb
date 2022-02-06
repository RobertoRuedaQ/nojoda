class AddChangesToFund < ActiveRecord::Migration[5.2]
  def change
    rename_column :funds, :student_location_origination, :student_location_origination_id
    rename_column :funds, :student_personal_information_origination, :student_personal_information_origination_id
    rename_column :funds, :student_contact_information_origination, :student_contact_information_origination_id
    rename_column :funds, :user_data_origination, :user_data_origination_id 
  end
end
