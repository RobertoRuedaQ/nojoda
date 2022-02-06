class AddModelingMainSencibilityToModelingSencibility < ActiveRecord::Migration[5.2]
  def change
    add_reference :modeling_sencibilities, :modeling_main_sencibility, foreign_key: true
  end
end
