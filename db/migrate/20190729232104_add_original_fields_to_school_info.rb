class AddOriginalFieldsToSchoolInfo < ActiveRecord::Migration[5.2]
  def change
    add_reference :school_infos, :student_academic_information, foreign_key: true
    add_column :school_infos, :school_year_failed_check, :boolean
    add_column :school_infos, :school_year_failed_text, :string
    add_column :school_infos, :average_score, :string
    add_column :school_infos, :problem_at_school_check, :boolean
    add_column :school_infos, :problem_at_school_text, :string
    add_column :school_infos, :accepted_in_university, :boolean
    add_column :school_infos, :reprimands_for_low_assistance, :boolean
    add_column :school_infos, :planning_to_take_preuniversity_classes, :boolean
  end
end
