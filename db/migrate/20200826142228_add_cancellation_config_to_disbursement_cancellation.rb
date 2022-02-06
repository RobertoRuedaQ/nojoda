class AddCancellationConfigToDisbursementCancellation < ActiveRecord::Migration[5.2]
  def change
    add_reference :disbursement_cancellations, :cancellation_config, foreign_key: true
  end
end
