class AddDoneToOriginationModule < ActiveRecord::Migration[5.2]
  def change
    add_column :origination_modules, :done, :boolean, default: false
  end
end
