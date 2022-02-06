class AddColumnsToStudentAcademicInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :student_academic_informations, :already_admitted, :string
    add_column :student_academic_informations, :change_city_to_study, :boolean, :default =>  false
    add_column :student_academic_informations, :study_modality, :string
    add_column :student_academic_informations, :last_academic_level_fulfilled, :string
  end
end
