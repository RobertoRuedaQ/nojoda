class AddAcademicBonusOriginationToDisbursementOrigination < ActiveRecord::Migration[5.2]
  def change
    add_reference :disbursement_originations, :bonus_origination, index: true
  end
end
