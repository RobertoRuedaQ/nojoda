class CreateClusters < ActiveRecord::Migration[5.2]
  def change
    create_table :clusters do |t|
      t.string :cluster_case
      t.string :value
      t.references :major, foreign_key: true

      ## Default Lumni fields
      t.string :external_id,          index: true
      t.datetime :discarded_at,       index: true
      t.boolean :migrated      

      t.timestamps
    end
    add_index :clusters, :cluster_case
    add_index :clusters, :value
  end
end
