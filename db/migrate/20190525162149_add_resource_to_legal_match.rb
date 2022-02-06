class AddResourceToLegalMatch < ActiveRecord::Migration[5.2]
  def change
    add_reference :legal_matches, :resource, polymorphic: true, index: true
  end
end
