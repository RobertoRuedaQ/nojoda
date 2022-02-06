class CreateBlackRockData < ActiveRecord::Migration[5.2]
  def change
    create_table :black_rock_data do |t|
      t.integer :number_of_children
      t.integer :people_in_charge
      t.string :dependent_on
      t.string :working
      t.string :reasons_to_apply
      t.integer :guardian_income
      t.string :guardian_income_origin
      t.string :family_income_level
      t.text :how_pandemic_affect
      t.string :how_know_about_benefit

      t.timestamps
    end
  end
end
