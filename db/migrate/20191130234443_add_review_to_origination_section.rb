class AddReviewToOriginationSection < ActiveRecord::Migration[5.2]
  def change
    add_column :origination_sections, :review, :boolean
  end
end
