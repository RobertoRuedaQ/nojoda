class AddApplicationToIsaAmendment < ActiveRecord::Migration[5.2]
  def change
    add_reference :isa_amendments, :application, foreign_key: true
  end
end
