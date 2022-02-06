class AddReferencedByToBizdevBusiness < ActiveRecord::Migration[5.2]
  def change
    add_column :bizdev_businesses, :referenced_by, :string
    add_column :bizdev_businesses, :source, :string
  end
end
