class TeamSupervisorBatch < ActiveRecord::Migration[5.2]
  def change
    create_table :team_supervisor_batches do |t|
      t.string :description
      t.datetime :discarded_at, index: true

      t.timestamps
    end
  end
end
