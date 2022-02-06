class AddLabelToCluster < ActiveRecord::Migration[5.2]
  def change
    add_column :clusters, :label, :string
  end
end
