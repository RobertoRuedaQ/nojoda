class AddAcademicStopOriginationToFund < ActiveRecord::Migration[5.2]
  def change
    add_column :funds, :academic_stop_origination_id, :integer
  end
end
