class FormAttribute < ApplicationRecord
      
      resourcify
      audited
  belongs_to :form_field, touch: true

  after_commit :flush_form_attribute

  def flush_form_attribute
    Rails.cache.clear
  end



  def form_template
  	self.form_field.form_template
  end
end
