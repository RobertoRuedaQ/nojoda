class AddAcademicBonusToUniversityGrade < ActiveRecord::Migration[5.2]
  def change
    add_reference :university_grades, :academic_bonus, foreign_key: { to_table: :disbursements }
  end
end
