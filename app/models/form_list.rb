class FormList < ApplicationRecord
      
  resourcify
  audited
  has_many :form_label,->{kept}, as: :resource , dependent: :destroy
  has_one :form_list_db, dependent: :destroy
  has_many :form_list_value, -> { kept.order(:order) }, dependent: :destroy
  has_many :list_input,-> {kept}, dependent: :destroy


  after_commit :flush_form_list

  def flush_form_list
    Rails.cache.clear
  end

  def user_label target_user
    self.translator target_user.language
  end


  def traduction? language
  	self.form_label.where(language: language).count > 0
  end

  def translator language
  	tempTranslation = self.translation_instance(language)
    if tempTranslation.nil?
      translation = self.case
    else
      translation = tempTranslation.label
    end
  end

  def translation_instance language
    self.form_label.find_by_language(language)
  end

  def get_list current_user, current_company
    list = nil
    form_list_value =  self.form_list_value.includes(:form_label).kept
    form_list_db = self.form_list_db
    if form_list_db.present?
      functionality_inputs = method(form_list_db.functionality.to_sym).parameters.map{|f| f.last.to_s}
      extra_params = functionality_inputs - ['current_user','current_company']
      target_params = functionality_inputs - extra_params
      list = eval(form_list_db.functionality + "(#{target_params.join(',')})")
    elsif form_list_value.any?
      temp_values = form_list_value.map{|v| v.value}
      temp_labels = form_list_value.map{|v| v.get_label(current_user.language).label}
      list = {}
      list[self.translator(current_user.language)] = {values: temp_values, labels: temp_labels}
    end
    return list
  end
end
