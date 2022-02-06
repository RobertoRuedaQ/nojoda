class AddFinalOriginationTextToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :final_origination_text, :text
    add_column :companies, :custom_origination_end, :boolean, default: :false
  end
end
