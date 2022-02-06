class AddWorkAndSocialToCancellationConfig < ActiveRecord::Migration[5.2]
  def change
    add_column :cancellation_configs, :social_work_hours, :float
    add_column :cancellation_configs, :certified_work_months, :float
  end
end
