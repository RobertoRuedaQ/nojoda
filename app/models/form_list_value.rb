class FormListValue < ApplicationRecord
      
      resourcify
      audited
  belongs_to :form_list
  has_many :form_label, as: :resource , dependent: :destroy

  after_commit :flush_form_list_value

  def get_label(language)
    form_labels = self.form_label
    result = form_labels.select{|fl| fl.language == language}.first
    if result.nil?
      result = form_labels.any? ? form_labels.first : 'Not defined'
    end
    return result
  end

  def flush_form_list_value
    Rails.cache.clear
  end

end
