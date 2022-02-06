class AddAdjustedFieldsToUniversityInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :university_infos, :accepted_in_university, :boolean
    add_column :university_infos, :reprimands_for_low_assistance, :boolean
  end
end
