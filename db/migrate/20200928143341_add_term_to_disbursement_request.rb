class AddTermToDisbursementRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :disbursement_requests, :term, :string
  end
end
