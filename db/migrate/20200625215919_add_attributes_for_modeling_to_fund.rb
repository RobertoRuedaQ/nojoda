class AddAttributesForModelingToFund < ActiveRecord::Migration[5.2]
  def change
    add_column :funds, :include_tuition_in_modeling, :boolean, default: true
  end
end
