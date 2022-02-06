class AddModelingInclusionToModelingFee < ActiveRecord::Migration[5.2]
  def change
    add_column :modeling_fees, :include_in_modeling, :boolean, default: true
  end
end
