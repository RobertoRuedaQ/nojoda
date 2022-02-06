class AddReviewFieldsToDisbursementOrigination < ActiveRecord::Migration[5.2]
  def change
    add_reference :disbursement_originations, :review_tuition, index: true
    add_reference :disbursement_originations, :review_living, index: true
  end
end
