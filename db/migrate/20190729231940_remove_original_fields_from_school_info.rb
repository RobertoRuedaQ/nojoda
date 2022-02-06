class RemoveOriginalFieldsFromSchoolInfo < ActiveRecord::Migration[5.2]
  def change
    remove_reference :school_infos, :student_academic_information, foreign_key: true
    remove_column :school_infos, :academic_bonus_granted, :boolean
    remove_column :school_infos, :shift, :string
    remove_column :school_infos, :number_subjects_taken, :integer
    remove_column :school_infos, :number_subjects_failed, :integer
    remove_column :school_infos, :problems_with_subjects_check, :boolean
    remove_column :school_infos, :problems_with_subjects_text, :string
  end
end
