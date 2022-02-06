class AddResourceToModelingMatch < ActiveRecord::Migration[5.2]
  def change
    add_reference :modeling_matches, :resource, polymorphic: true, index: true
  end
end
