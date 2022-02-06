class AddResourceToProyect < ActiveRecord::Migration[5.2]
  def change
    add_reference :projects, :resource, polymorphic: true, index: true
  end
end
