class AddParamsToApiHistory < ActiveRecord::Migration[5.2]
  def change
    add_column :api_histories, :params, :text
  end
end
