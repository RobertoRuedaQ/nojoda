class RemoveOriginalFieldsFromUniversityInfo < ActiveRecord::Migration[5.2]
  def change
    remove_reference :university_infos, :student_academic_information, foreign_key: true
    remove_column :university_infos, :school_year_failed_check, :boolean
    remove_column :university_infos, :school_year_failed_text, :string
    remove_column :university_infos, :average_score, :string
    remove_column :university_infos, :problem_at_school_check, :boolean
    remove_column :university_infos, :problem_at_school_text, :string
    remove_column :university_infos, :accepted_in_university, :boolean
    remove_column :university_infos, :reprimands_for_low_assistance, :boolean
    remove_column :university_infos, :planning_to_take_preuniversity_classes, :boolean
  end
end
