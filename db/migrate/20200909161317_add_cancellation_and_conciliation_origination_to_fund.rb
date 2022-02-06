class AddCancellationAndConciliationOriginationToFund < ActiveRecord::Migration[5.2]
  def change
    add_reference :funds, :cancellation_origination, index: true
    add_reference :funds, :conciliation_origination, index: true
  end
end
