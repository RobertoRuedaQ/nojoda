class AddFundingNeedCheckToStudentAcademicInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :student_academic_informations, :funding_need, :boolean
  end
end
