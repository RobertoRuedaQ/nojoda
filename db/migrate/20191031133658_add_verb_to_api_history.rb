class AddVerbToApiHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :api_histories, :verb, :string
  end
end
