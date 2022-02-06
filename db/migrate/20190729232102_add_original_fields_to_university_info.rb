class AddOriginalFieldsToUniversityInfo < ActiveRecord::Migration[5.2]
  def change
    add_reference :university_infos, :student_academic_information, foreign_key: true
    add_column :university_infos, :academic_bonus_granted, :boolean
    add_column :university_infos, :shift, :string
    add_column :university_infos, :number_subjects_taken, :integer
    add_column :university_infos, :number_subjects_failed, :integer
    add_column :university_infos, :problems_with_subjects_check, :boolean
    add_column :university_infos, :problems_with_subjects_text, :string
  end
end
