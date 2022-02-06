class AddOriginationLivingExpensesToDisbursementOrigination < ActiveRecord::Migration[5.2]
  def change
    add_reference :disbursement_originations, :origin_living, index: true
  end
end
