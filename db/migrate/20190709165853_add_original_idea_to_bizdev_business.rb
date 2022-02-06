class AddOriginalIdeaToBizdevBusiness < ActiveRecord::Migration[5.2]
  def change
    add_reference :bizdev_businesses, :original_idea, index: true
  end
end
