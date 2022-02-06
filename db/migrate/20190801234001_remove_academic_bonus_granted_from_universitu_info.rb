class RemoveAcademicBonusGrantedFromUniversituInfo < ActiveRecord::Migration[5.2]
  def change
    remove_column :university_infos, :academic_bonus_granted, :boolean
  end
end
