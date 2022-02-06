class AddLidershipToSchoolInfo < ActiveRecord::Migration[5.2]
  def change
    add_column :school_infos, :lidership, :string
  end
end
