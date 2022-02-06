class AddStatusToModelingMatch < ActiveRecord::Migration[5.2]
  def change
    add_column :modeling_matches, :status, :string
  end
end
