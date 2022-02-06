class CreateNotAlloweds < ActiveRecord::Migration[5.2]
  def change
    create_table :not_alloweds do |t|

      t.timestamps
    end
  end
end
