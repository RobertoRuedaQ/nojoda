class AddCronVariablesToPayuResponse < ActiveRecord::Migration[5.2]
  def change
    add_column :payu_responses, :last_review_datetime, :datetime
  end
end
