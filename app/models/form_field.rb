class FormField < ApplicationRecord
      
  resourcify
  audited
  belongs_to :form_template,touch: true
  has_many :form_attribute,->{kept}, dependent: :destroy
  has_many :form_input,->{kept}, dependent: :destroy

  after_commit :flush_form_field


  def flush_form_field
    Rails.cache.clear
  end




  def field_options current_user,current_company,template

  	options = {}
  	options[:field_type] = self.format
    options[:grid] = self.grid
    options[:model] = template.object.downcase
    options[:original_model] = template.object
  	self.form_attribute.each do | attribute|
      if attribute.name == 'list' || attribute.name == 'multiple_dropdown'
        options[:list_number] = attribute.value.to_i
        options[attribute.name.to_sym] = FormList.cached_find(attribute.value.to_i).get_list(current_user,current_company)
      else
    		options[attribute.name.to_sym] = attribute.value
      end
  	end
  	return options
  end

  def cached_field_options current_user,current_company, template
    Rails.cache.fetch([self.id, 'field_options']){field_options(current_user,current_company, template)}
  end

  def flush_field_options
    Rails.cache.delete([self.id, 'field_options'])
  end
end
