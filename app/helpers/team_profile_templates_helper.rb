module TeamProfileTemplatesHelper
	def createProfileTemplateTable team_profile_id
		@team_profile = TeamProfile.cached_find(team_profile_id)
		table_info = @team_profile.template_array


		table_info.each_with_index do |row,index|
			
			table_info[index][2] = lumni_dropdown_field('teamprofiletemplate','form_template_id',{list: cached_listProfileTemplateByModel(row.first),value: row.last})
		end


		createBasicTable([I18n.t('general.model'),I18n.t('general.controller'),I18n.t('general.template')],table_info,id: 'template-table-id')

	end

	def cached_listProfileTemplateByModel model 
		Rails.cache.fetch(['listProfileTemplateByModel',model]){listProfileTemplateByModel model}
	end

	def listProfileTemplateByModel model
		tempTemplates = FormTemplate.where(object: model)
		list ={}
		list[:templates] = {values: tempTemplates.ids, labels: tempTemplates.map{|t| t.name} }
		return list
	end
end
