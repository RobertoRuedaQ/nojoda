class AddReferenceCaseToReference < ActiveRecord::Migration[5.2]
  def change
    add_column :references, :reference_case, :string
  end
end
