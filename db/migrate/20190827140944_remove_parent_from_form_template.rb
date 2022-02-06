class RemoveParentFromFormTemplate < ActiveRecord::Migration[5.2]
  def change
    remove_reference :form_templates, :parent, index: true
  end
end
