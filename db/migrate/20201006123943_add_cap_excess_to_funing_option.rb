class AddCapExcessToFuningOption < ActiveRecord::Migration[5.2]
  def change
    add_column :funding_options, :cap_excess, :float
  end
end
