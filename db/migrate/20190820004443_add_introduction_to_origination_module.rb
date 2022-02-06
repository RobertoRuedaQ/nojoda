class AddIntroductionToOriginationModule < ActiveRecord::Migration[5.2]
  def change
    add_column :origination_modules, :introduction, :text
    add_column :origination_modules, :options, :string
  end
end
