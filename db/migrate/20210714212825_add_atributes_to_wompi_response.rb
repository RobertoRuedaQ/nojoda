class AddAtributesToWompiResponse < ActiveRecord::Migration[5.2]
  def change
    add_column :wompi_responses, :status_detail, :string, default: ''
  end
end
