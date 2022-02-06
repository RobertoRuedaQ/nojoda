class AddJobPoolToIncomeInformation < ActiveRecord::Migration[5.2]
  def change
    add_column :income_informations, :job_pool, :string
  end
end
