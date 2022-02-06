class AddFundingOptionsDisplayDateToApplication < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :funding_options_display_date, :date
  end
end
