class AddIsaToCancellationRequest < ActiveRecord::Migration[5.2]
  def change
    add_reference :cancellation_requests, :isa, foreign_key: true
  end
end
