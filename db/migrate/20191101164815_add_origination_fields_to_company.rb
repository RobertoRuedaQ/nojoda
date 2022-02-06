class AddOriginationFieldsToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :automatic_proposal_display, :boolean
  end
end
