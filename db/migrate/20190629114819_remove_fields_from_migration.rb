class RemoveFieldsFromMigration < ActiveRecord::Migration[5.2]
  def change
    remove_column :migrations, :fund, :string
    remove_reference :migrations, :company, foreign_key: true
    remove_column :migrations, :new_fund_name, :string
  end
end
