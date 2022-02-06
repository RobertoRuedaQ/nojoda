class AddParentToFormTemplate < ActiveRecord::Migration[5.2]
  def change
    add_reference :form_templates, :parent, index: true
  end
end
