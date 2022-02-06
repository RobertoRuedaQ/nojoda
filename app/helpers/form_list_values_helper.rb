module FormListValuesHelper
	def form_list_index_header
		form_list_index_elements.map{|field| FormList.human_attribute_name(field)}
	end

	def form_list_index_rows form_lists
		form_lists.map{|l| tranlate_form_list_items(l)}
	end

	def tranlate_form_list_items list


		result = []
		form_list_index_elements.each do |field| 
			case field
			when 'user_label'
				result += [list.translator( current_user.language)]
			when 'id'
				result += [link_to( list.send(field),edit_form_list_path(list),class: 'text-primary')]
			else
				result += [list.send(field)]
			end
		end
		return result
	end



	def form_list_index_elements
		['id','case','user_label']
	end


	def createFormLabelForm language,formListValueId
		@form_list_value = FormListValue.cached_find(formListValueId)
		@form_label =  @form_list_value.form_label.find_by_language(language)
		if @form_label.nil?
			@form_label = FormLabel.new({resource_id: formListValueId,resource_type: 'FormListValue',language: language})
		end



		if @form_label.id.nil?
			@labelText = I18n.t('list.not_defined')
		else
			@labelText = @form_label.label
		end

		@form_label_id = @form_list_value.value + '-' + language + '-' + (@form_label.id.nil? ? @form_list_value.id.to_s : @form_label.id.to_s)





		render 'form_lists/partial/labels_form'

	end

	def createBodyTableFormLabel formListId
		@form_list = FormList.cached_find(formListId)
		group = @form_list.form_label.find_by_language(current_user.language)
		if group.nil?
			group = I18n.t('list.not_defined')
		else
			group = group.label
		end


		language = languageList[:language][:values]
		labels = [I18n.t('list.group'),I18n.t('list.values')] + languageList[:language][:labels]
		@header = labels
		@table_body = []

		@form_list.form_list_value.kept.each_with_index do |value, index|
			@table_body[index] = [group,modifyFormListValue(value.id)]
			language.each do | l |
				@table_body[index] += [createFormLabelForm( l,value.id)]
			end
		end
	end

	def modifyFormListValue valueId
		@value = FormListValue.cached_find(valueId)
		render 'form_lists/partial/modify_form_list_value'

	end
end
