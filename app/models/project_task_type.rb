class ProjectTaskType < ApplicationRecord
  resourcify
  audited
  has_many :project_task_translate

  def translation language
  	tempTranslation = self.project_task_translate.where(language: language)
  	if tempTranslation.count > 0
  		translation = tempTranslation.first
  	else
  		translation = ProjectTaskTranslate.new({language: language,project_task_type_id: self.id})
  	end
  	return translation
  end

  def target_name language
  	tempTranslation = self.translation language
  	target_text = ''
  	if !tempTranslation.id.nil?
  		target_text = tempTranslation.name
  	else
  		target_text = self.title
  	end
  	return target_text
  end

  def target_description language
  	tempTranslation = self.translation language
  	target_text = ''
  	if !tempTranslation.id.nil?
  		target_text = tempTranslation.description
  	else
  		target_text = self.description
  	end
  	return target_text
  end
end
