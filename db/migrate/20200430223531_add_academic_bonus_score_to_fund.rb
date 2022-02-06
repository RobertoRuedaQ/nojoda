class AddAcademicBonusScoreToFund < ActiveRecord::Migration[5.2]
  def change
    add_column :funds, :bonus_min_score, :float
    add_column :funds, :bonus_valuer, :float
  end
end
