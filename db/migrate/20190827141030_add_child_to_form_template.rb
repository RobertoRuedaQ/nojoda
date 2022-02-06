class AddChildToFormTemplate < ActiveRecord::Migration[5.2]
  def change
    add_reference :form_templates, :child, index: true
  end
end
