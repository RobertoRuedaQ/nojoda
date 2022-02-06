class AddControlVariablesToCancellationConfig < ActiveRecord::Migration[5.2]
  def change
    add_column :cancellation_configs, :ejecution_type, :string
    add_column :cancellation_configs, :max_general, :float
  end
end
