class AddOptionsToOriginationSection < ActiveRecord::Migration[5.2]
  def change
    add_column :origination_sections, :options, :text
  end
end
