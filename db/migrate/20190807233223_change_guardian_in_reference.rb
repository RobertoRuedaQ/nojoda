class ChangeGuardianInReference < ActiveRecord::Migration[5.2]
  def change
  	change_column :references, :guardian, :string
  end
end
