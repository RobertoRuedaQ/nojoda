class RemoveReferenceFromModelingMatch < ActiveRecord::Migration[5.2]
  def change
    remove_reference :modeling_matches, :reference, polymorphic: true
  end
end
