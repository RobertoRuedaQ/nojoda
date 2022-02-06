class AddAlternativeLabelToOriginationSection < ActiveRecord::Migration[5.2]
  def change
    add_column :origination_sections, :alternative_label, :string
  end
end
