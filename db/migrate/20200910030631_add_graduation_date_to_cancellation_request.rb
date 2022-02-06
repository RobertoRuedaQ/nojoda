class AddGraduationDateToCancellationRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :cancellation_requests, :graduation_date, :date
  end
end
