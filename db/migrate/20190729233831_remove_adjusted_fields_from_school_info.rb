class RemoveAdjustedFieldsFromSchoolInfo < ActiveRecord::Migration[5.2]
  def change
    remove_column :school_infos, :accepted_in_university, :boolean
    remove_column :school_infos, :reprimands_for_low_assistance, :boolean
  end
end
