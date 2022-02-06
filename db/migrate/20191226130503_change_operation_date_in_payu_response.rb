class ChangeOperationDateInPayuResponse < ActiveRecord::Migration[5.2]
  def change
  	change_column :payu_responses, :operation_date, :string
  end
end
