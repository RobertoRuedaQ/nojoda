class AddYoungAgeToCompany < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :min_self_representation_age, :integer
  end
end
