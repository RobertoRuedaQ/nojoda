class AddIsaToConciliationInformation < ActiveRecord::Migration[5.2]
  def change
    add_reference :conciliation_informations, :isa, foreign_key: true
  end
end
