class FormLabel < ApplicationRecord
      
      resourcify
      audited
  	belongs_to :resource, polymorphic: true

  	after_commit :flush_form_label

  def flush_form_label
    Rails.cache.clear
  end

end
