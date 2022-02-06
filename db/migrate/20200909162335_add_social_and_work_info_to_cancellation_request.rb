class AddSocialAndWorkInfoToCancellationRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :cancellation_requests, :social_hours, :float
    add_column :cancellation_requests, :company_name, :string
    add_column :cancellation_requests, :company_start_date, :date
    add_column :cancellation_requests, :company_end_date, :date
  end
end
