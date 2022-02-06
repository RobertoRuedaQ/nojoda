class AddPhilosophyToSchoolGrade < ActiveRecord::Migration[5.2]
  def change
    add_column :school_grades, :philosophy, :string
    add_column :school_grades, :academic_term, :string
  end
end
