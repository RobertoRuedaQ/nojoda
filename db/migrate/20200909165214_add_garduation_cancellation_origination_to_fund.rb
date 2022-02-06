class AddGarduationCancellationOriginationToFund < ActiveRecord::Migration[5.2]
  def change
    add_reference :funds, :graduation_cancellation_origination, index: true
  end
end
