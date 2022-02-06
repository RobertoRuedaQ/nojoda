class AddAcademicConfigToFund < ActiveRecord::Migration[5.2]
  def change
    add_column :funds, :course_inscription, :boolean
    add_column :funds, :partial_scores, :boolean
    add_column :funds, :final_scores, :boolean
  end
end
