class OriginationSection < ApplicationRecord
      
  resourcify
  audited
  belongs_to :origination_module, touch: true
  belongs_to :resource, polymorphic: true
  belongs_to :legal_document, ->{joins(:origination_section).where(origination_sections: {resource_type: 'LegalDocument'})},class_name: 'LegalDocument', foreign_key: 'resource_id', optional: true
  belongs_to :questionnaire, ->{joins(:origination_section).where(origination_sections: {resource_type: 'Questionnaire'})},class_name: 'Questionnaire', foreign_key: 'resource_id', optional: true
  belongs_to :form_template, ->{joins(:origination_section).where(origination_sections: {resource_type: 'FormTemplate'})}, class_name: 'FormTemplate',  foreign_key: 'resource_id', optional: true
  has_many :application_section_track,->{kept}
  has_many :user_questionnaire,->{kept}, as: :resource, dependent: :destroy

  after_commit :flush_origination_section

  def flush_origination_section
    Rails.cache.delete(['cached_origination_section_from_module',self.origination_module_id])
    Rails.cache.fetch(['origination_section_cached_form_template',self.id])
  end

  def last_section?
    my_module = self.origination_module
    my_origination = my_module.origination
    my_origination.origination_module.maximum(:order) == my_module.order && my_module.origination_section.maximum(:order) == self.order
  end

  # after_commit :flush_done

  def user_questionnaire_by_appplication application
    result = self.user_questionnaire.select{|uq| uq.application_id == application.id}.last
    if result.nil?
      result = UserQuestionnaire.create({user_id: application.user_id,questionnaire_id: self.resource_id,status: 'active',resource_id: self.id,resource_type: 'OriginationSection',application_id: application.id}) 
    end  
    return result    
  end

  def done? application, section
    return true unless pending_for_trakking?(application)
    case self.resource_type
    when 'FormTemplate'
      result = self.application_section_track.select{|a| a.application_id == application.id}.any?
    when 'Questionnaire'
      user_questionnaire = self.user_questionnaire_by_appplication application
      result = user_questionnaire.status == 'finished' && user_questionnaire.approved?
      if result == true
        add_application_section_track(application, section)
      end
    when 'LegalDocument'
      result = application.legal_match.kept.where(legal_document_id: self.resource_id).size > 0
      if result == true
        add_application_section_track(application, section)
      end
    end
    return result
  end
  
  def add_application_section_track(application, section)
    CreateRecordAsync.perform_async('application_section_track', {origination_section_id: section.id, application_id: application.id})
  end

  def pending_for_trakking?(application)
    self.application_section_track.select{|a| a.application_id == application.id}.empty?
  end

  def cached_done? application, section
    Rails.cache.fetch(['applicationcached_done?',self.id,'-',application.id],expires_in: 1.day){done?(application, section)}
  end

  def cached_form_template
    Rails.cache.fetch(['origination_section_cached_form_template',self.resource_id]){resource}
  end





  # def flush_done
  # 	Rails.cache.delete(['originationsectiondone',self.id,'app',application.id])
  # end

  # def regular_done application
  # 	case self.resource_type
  # 	when 'FormTemplate'
	 #  	result = self.application_section_track.where(application_id: application.id).count > 0
	 #  when 'Questionnaire'
	 #  	user_questionnaire = application.user_questionnaire.kept.find_by_questionnaire_id(self.resource_id)
	 #  	result = user_questionnaire.approved?
	 #  when 'LegalDocument'
	 #  	result = application.legal_match.kept.where(legal_document_id: self.resource_id).count > 0
	 #  end
	 #  return result
  # end


end
