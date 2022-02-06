class AddRankingToStudentAcademicInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :student_academic_informations, :standardized_state_test_ranking, :string
  end
end
