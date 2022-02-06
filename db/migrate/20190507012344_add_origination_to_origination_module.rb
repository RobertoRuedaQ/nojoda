class AddOriginationToOriginationModule < ActiveRecord::Migration[5.2]
  def change
    add_reference :origination_modules, :origination, foreign_key: true
  end
end
