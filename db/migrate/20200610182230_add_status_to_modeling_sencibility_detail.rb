class AddStatusToModelingSencibilityDetail < ActiveRecord::Migration[5.2]
  def change
    add_column :modeling_sencibility_details, :status, :string
  end
end
