class AddDiseasesOtherToHealth < ActiveRecord::Migration[5.2]
  def change
    add_column :healths, :diseases_other, :string
  end
end
