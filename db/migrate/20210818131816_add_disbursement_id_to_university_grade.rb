class AddDisbursementIdToUniversityGrade < ActiveRecord::Migration[5.2]
  def change
    add_reference :university_grades, :disbursement, foreign_key: true
  end
end
