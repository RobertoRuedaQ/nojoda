class AddParentToIncomeInformation < ActiveRecord::Migration[5.2]
  def change
    add_reference :income_informations, :parent, index: true
  end
end
