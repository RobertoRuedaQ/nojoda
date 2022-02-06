class AddStationCodeToInfoTerpel < ActiveRecord::Migration[5.2]
  def change
    add_column :info_terpels, :station_code, :string
  end
end
