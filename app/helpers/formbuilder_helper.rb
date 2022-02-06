module FormbuilderHelper

	def build_accordion headers, bodies, options = {}
		title = SecureRandom.hex

		hash_options = {headers: headers,bodies: bodies,options: options,title: title}
		render '/forms/accordion', hash_options
	end

	def build_form(targetRecord,action,fields,options={})
		if action == 'create'
			options[:history] = false
		end

		options[:form_key] = SecureRandom.hex

		@targetRecord = targetRecord
		@action = action
		@controller = options[:controller].nil? ? params[:controller] : options[:controller]
		@htmlContent = options[:html]
		@fields = [fields].flatten

		if current_user.allowed_just_view?(params) || options[:locked] == true
			options[:save] = false

			@fields.each do |temp_field|
				temp_field.keys.each do |k|
					temp_field[k.to_sym][:disabled] =  true
				end
			end
		end

		@options = options
		

		render '/forms/build_forms'
		
	end

	def form_title(object,title=nil,options = {})
		@object = object
		if title.nil?
			begin
				@object_title = object.model_name.human(count: 2)
			rescue Exception => e
			@object_title = object.model_name.human
			end
		else
			begin
				@object_title = object.send(title)
			rescue Exception => e
				@object_title = title
			end
		end
		@title = title
		if title.nil?
			options[:record_info] = false
		end
		@options = options
		render '/forms/form_title'

	end

	def default_fields options

		if options[:error_message].nil?
			options[:error_text] = I18n.t('form.error.' + options[:type].to_s ).to_json
		else
			options[:error_text] = I18n.t( options[:error_message]).to_json
		end
		
		options[:error_text].gsub! '%{min}', options[:min].to_s
		options[:error_text].gsub! '%{max}', options[:max].to_s
		options[:error_text].gsub! '%{minlength}', options[:minlength].to_s
		options[:error_text].gsub! '%{maxlength}', options[:maxlength].to_s

		return options
	end		

	def translate_approval_input object
		approval_hash = {}
		object.pending_changes.each do |target_change|
			approval_hash = approval_hash.merge(target_change.params)
		end
		return approval_hash
	end

	def translate_approval_values_from_list target_hash, options, field
		if options[:list].nil? && !target_hash[field.to_s].nil?
			result = target_hash[field.to_s]
		elsif !target_hash[field.to_s].nil?
			result = find_label_from_list target_hash[field.to_s], options[:list]
		else
			result = nil
		end
		return result
	end


	def fieldGroup(object,fields,filter,config={})

		# Approval Check
		approval_hash = {}
		begin
			if object.pending_changes.count > 0
				approval_hash = translate_approval_input object
			end
			
		rescue Exception => e
			
		end



		if !config[:template_field].nil?
			@form_field_id = config[:template_field]
		end

		group_fields = [filter].flatten

		@fieldResult = content_tag(:div, class: 'form-row') do
			group_fields.each do |adjusted_filter|
				current_object = adjusted_filter.values.map{|v| v[:original_model]}.uniq.first
				
				if current_object.nil? || current_object == object.class.to_s || ('User' == object.class.to_s && ['Student','Team','Applicant','Profile'].include?(current_object))
					target_object = object
				else
					begin
						target_object = object.send(current_object)
						if target_object.nil?
							eval("target_object = #{current_object}.new")
						end
					rescue Exception => e
						eval("target_object = #{current_object}.new")
					end
				end
				
				
				target_fields = fields & adjusted_filter.keys
				target_fields.each do |f|
					fieldType = define_field_type target_object,f,adjusted_filter,config
					options = {}

					adjusted_filter[f].keys.each do | k |
						options[k] = adjusted_filter[f][k]
					end	

					if adjusted_filter[f].is_a? Hash
						if !adjusted_filter[f][:required].nil? && adjusted_filter[f][:required]
							options[:required] = '<span class="text-danger">*</span>'
						else
							options[:required] = ''
						end
						if !adjusted_filter[f][:hidden].nil?
							options[:hidden] = adjusted_filter[f][:hidden]
						end
						if adjusted_filter[f][:tooltip].present?
							options[:tooltip] = adjusted_filter[f][:tooltip]
						end
					end


					unless system_variables.index(f.to_s).nil?
						if params[:action] == 'new'
							options[:hidden] = true
						end
					end


					label_text = adjusted_filter[f][:custom_label].nil? ? eval("#{adjusted_filter[f][:original_model].nil? ? target_object.class : adjusted_filter[f][:original_model]}.human_attribute_name(f.to_s)") : adjusted_filter[f][:custom_label]
					target_id = target_object.id.nil? ? config[:form_key] : target_object.id

					if adjusted_filter[f][:placeholder].nil?
						adjusted_filter[f][:placeholder] = label_text
					end

					approval_value = translate_approval_values_from_list approval_hash, options, f
					
					concat content_tag(:div,
						content_tag(:div, 
						content_tag(:label, ('<span>' + label_text + options[:required] + '</span>').html_safe, class: 'form-label',hidden: options[:hidden])+
						content_tag(:span,options[:tooltip].nil? ? '' : ('<i class="ion ion-md-help-circle" data-toggle="popover" data-trigger="hover click" data-placement="top" data-content="' + options[:tooltip] + '" ></i>').html_safe,class: 'ml-2 text-warning')+
						(content_tag(:span, (render 'form_templates/partial/edition_buttons')) if !config[:template_field].nil?),
						class: 'd-flex') +
						content_tag(:div, lumni_field_selector(target_object,f.to_s,adjusted_filter,config), form_key: config[:form_key],id: "general_container-#{options[:original_model].to_s.downcase}_#{f}_#{target_id}",options: options,model: options[:original_model].to_s.downcase,list_number:  options[:list_number],field: f, config: config.dup.except(:filter,:object)) +
						(approval_value.nil? ? nil : content_tag(:div,content_tag(:small,content_tag(:h6, approval_value ,class: 'm-1'),class: 'badge badge-info d-flex'),class: 'm-1')),
						class: ('form-group col-md-' + (options[:grid].nil? ? 6.to_s : options[:grid].to_s)), form_key: config[:form_key],id: "form_group-#{options[:original_model].to_s.downcase}_#{f}_#{target_id}",hidden: options[:hidden] )


					## To visualize hidden fields in the form template section
					if options[:hidden] && params[:controller] == 'form_templates'
						concat content_tag(:div,
							content_tag(:div, 
							content_tag(:label, ('<span>' + label_text + options[:required] + '</span>').html_safe, class: 'form-label text-secondary')+
							content_tag(:span,options[:tooltip].nil? ? '' : ('<i class="ion ion-md-help-circle" data-toggle="popover" data-trigger="hover click" data-placement="top" data-content="' + options[:tooltip] + '" ></i>').html_safe,class: 'ml-2 text-warning')+
							(content_tag(:span, (render 'form_templates/partial/edition_buttons')) if !config[:template_field].nil?),
							class: 'd-flex justify-content-between'),
							class: ('form-group col-md-' + (options[:grid].nil? ? 6.to_s : options[:grid].to_s)), form_key: config[:form_key],id: "form_group-#{options[:original_model].to_s.downcase}_#{f}_#{target_id}" ) 
					end


				end	
			end
		end



	end

	def define_field_type object,f,filter,config={}
		begin
				if !filter[f.to_sym][:field_type].nil?
					fieldType = filter[f.to_sym][:field_type]
				else
					Rails.application.eager_load!
					if !filter[f.to_sym][:original_model].nil?
						fieldType = eval("#{filter[f.to_sym][:original_model]}.columns_hash[f].type")
					else
						fieldType = object.class.columns_hash[f].type
					end
				end

		rescue
			begin
				if object.class.columns_hash[f.to_s + '_id'].type.to_s == 'integer'
					fieldType = 'reference'
				end
			rescue
				fieldType = 'notDefined'
			end
		end

		return fieldType
	end



	def lumni_field_selector object,f,filter,config={}

		fieldType = define_field_type object,f,filter,config

		field_content = ''
		options = {}


		if filter[f.to_sym].is_a? Hash

			filter[f.to_sym].keys.each do | k |
				options[k] = filter[f.to_sym][k] 
			end

			if options[:model].nil?
				modelName = object.class.to_s.downcase
			else
				modelName = options[:model]
			end

			if options[:id].nil?
				options[:id] = object.id.nil? ? config[:form_key].to_s : object.id.to_s
			end


			if options[:value].nil?
				if object.send(f).nil? && !options[:default_value].nil?
					if ['false','true'].include?(options[:default_value])
						options[:value] = eval(options[:default_value])
						object[f] = eval(options[:default_value])
					else
						options[:value] = options[:default_value]
						object[f] = options[:default_value]
					end
				else
					options[:value] = object.send(f)
				end
			end



			list_exceptions = ['countries','regions','cities','institution','majors']


			if filter[f.to_sym][:list].is_a?( Hash) && !list_exceptions.include?(fieldType)
				fieldType = 'list'
			end

			if filter[f.to_sym][:legal_language].is_a? Hash
				fieldType = 'legal_language'
				options[:list] = filter[f.to_sym][:legal_language]
			end

			if filter[f.to_sym][:multiple_dropdown].is_a? Hash
				fieldType = 'multiple_dropdown'
				options[:list] = filter[f.to_sym][:multiple_dropdown]
			end


		end

		unless system_variables.index(f).nil?
			options[:disabled] = true
			if params[:action] == 'new'
				fieldType = 'empty'
			end
		end

		options[:type] = fieldType
		options[:form_key] = config[:form_key]

		case fieldType.to_s
		when 'boolean'
			field_content = lumni_boolean_field(modelName,f,options)
		when 'string'
			options[:type] = 'text'
			field_content = lumni_text_field(modelName,f,options)
		when 'text'
			field_content = lumni_textarea_field(modelName,f,options)
		when 'integer','float','decimal','percentage','currency','plain_number'
			options[:type] = 'number'
			field_content = lumni_text_field(modelName,f,options)
		when 'file', 'multiple_file'
			field_content = lumni_file_field(modelName,f,options,object: object)
		when 'inet'
			field_content = content_tag(:div,'inet')
		when 'date','datetime'
			options[:type] = 'text'
			#it's important the space before the class add
			options[:class] = " lumni_#{fieldType.to_s} " + (options[:class].nil? ? '' : options[:class])
			field_content = lumni_text_field(modelName,f,options)
		when 'list','reference','legal_language', 'multiple_dropdown'
			field_content = lumni_dropdown_field( modelName,f,options,filter)
		when 'email'
			options[:type] = 'email'
			field_content = lumni_text_field(modelName,f,options)
		when 'editor'
			field_content = lumni_editor_field(modelName,f,options)
		when 'full_editor'
			field_content = lumni_full_editor_field(modelName,f,options)
		when 'notDefined'
			field_content = content_tag(:div,'Not Defined')
		when 'empty'
			field_content = ''
		when 'countries'
			field_content = lumni_countries_field(modelName,f,options,filter: filter,object: object)
		when 'regions'
			field_content = lumni_regions_field(modelName,f,options,filter: filter,object: object)
		when 'cities'
			field_content = lumni_cities_field(modelName,f,options,filter: filter,object: object)
		when 'institution'
			field_content = lumni_institution_field(modelName,f,options,filter: filter,object: object)
		when 'majors'
			field_content = lumni_majors_field(modelName,f,options,filter: filter,object: object)
		end

		return field_content


	end

	def lumni_file_field model,f,options,config={}
		default_fields options
		render 'forms/file_field', target_model: model, target_field: f,options: options, config: config
	end

	def lumni_text_field model,f,options,config={}
		options[:type] = options[:field_type] if options[:type].nil?
		options[:type] = 'string' if options[:type].nil?
		options = default_fields(options)


		numeric_types = ['integer','float','decimal','percentage','number','currency']
		numeric_validation = numeric_types.include?(options[:field_type])
		numericField = ''

		

		case options[:field_type]
		when 'integer'
			options[:step] = 1 if options[:step].nil?
		when 'currency'
			if current_company.country.currency == 'PEN'
				options[:prefix] = 'S/ '
			else
				options[:prefix] = '$ ' if options[:prefix].nil?
			end
		when 'percentage'
			options[:postfix] = '%'
		end

		if options[:step].nil?
			options[:step] = 0.01
		end

		if f == 'identification_number' && controller_name != 'payment_mass_details'
			options[:pattern] = '\d*'
		end


		if numeric_validation
			numericField = content_tag(:input,nil,class: 'form-control scroll-top numericField' + options[:class].to_s,
										prefix: options[:prefix], postfix: options[:postfix],disabled: options[:disabled],
										id: model + '_' + f + '_' + options[:id].to_s + 'numericField',form_key: options[:form_key],
										max: options[:max],
										min: options[:min],
										pattern: options[:pattern],
										oninvalid: "setErrroMessage(this,'#{options[:error_text]}','#{options[:type]}')",
										placeholder: options[:placeholder], hidden: options[:hidden],oninput: "removeErrorMessage(this,'#{options[:type]}')",
										onfocusin:"passtheball('#{model + '_' + f + '_' + options[:id].to_s + 'numericField'}','#{model + '_' + f + '_' + options[:id].to_s}')")
		end

		numericField.html_safe +
		content_tag(:input,nil, autocomplete: f, value: options[:value], data: options[:data], name: model + '[' + f + ']',placeholder: options[:placeholder],
			class: 'form-control scroll-top ' + options[:class].to_s , type: options[:type],id: model + '_' + f + '_' + options[:id].to_s,
				min: options[:min], max: options[:max],	pattern: options[:pattern], minlength: options[:minlength],maxlength: options[:maxlength],disabled: options[:disabled],
				style: numeric_validation ? "display: none;" : nil, step: options[:step],form_key: options[:form_key],lumni_validation: options[:lumni_validation],
				required: options[:required], hidden: options[:hidden], 'data-date-language' => I18n.locale,direct_upload: options[:direct_upload],
				oninvalid: "setErrroMessage(this,'#{options[:error_text]}','#{options[:type]}')",oninput: "removeErrorMessage(this,'#{options[:type]}')",
				onfocusout:(numeric_validation ? "passtheballback('#{model + '_' + f + '_' + options[:id].to_s}','#{model + '_' + f + '_' + options[:id].to_s + 'numericField'}','','')" : nil))
		
	end


	def lumni_boolean_field model,f,options,config={}
		options[:type] = options[:field_type] if options[:type].nil?
		options[:type] = 'boolean' if options[:type].nil?
		options = default_fields(options)

		status = {type: 'checkbox', class: ("switcher-input " + options[:switcher_input_class].to_s) ,value: options[:value], name: model + '_' + f + '_',
		 id: model + '_' + f + '_' + options[:id].to_s + 'frontcheck',disabled: options[:disabled], required: options[:required], hidden: options[:hidden],
		 oninvalid: "setErrroMessage(this,'#{options[:error_text]}','#{options[:type]}')",oninput: "removeErrorMessage(this,'#{options[:type]}')"}

		if options[:value]
			status[:checked] = true
		end
		if !options[:boolean_text].nil?
			begin
			  boolean_text = I18n.t(options[:boolean_text], :raise => I18n::MissingTranslationData)
			rescue
			  boolean_text = options[:boolean_text]
			end
		else
			boolean_text = ''
		end
		

		content_tag(:div,nil, class: 'col-12') +
		content_tag(:input,nil,value: options[:value],hidden: true, name: model + '[' + f + ']',form_key: options[:form_key],id: model + '_' + f + '_' + options[:id].to_s,dependent: options[:dependent])+
		content_tag(:label,class: "switcher #{options[:switcher_class]}") do 
			concat content_tag(:input, nil,  status , hidden: options[:hidden])
			concat content_tag(:span,
				content_tag(:span, content_tag(:span,nil,class: 'ion ion-md-checkmark') , class: 'switcher-yes') + 
				content_tag(:span, content_tag(:span,nil,class: 'ion ion-md-close'), class: 'switcher-no'),
				class: 'switcher-indicator', hidden: options[:hidden])
			concat content_tag(:span,nil,class: 'switcher-label')
			concat content_tag(:span, boolean_text.html_safe,class: 'form-label')
		end
	end

	def get_dependent config, field_type
		filter = config[:filter]
		dependent_position = filter.values.map{|v| v[:field_type]}.index(field_type)
		dependent_field = filter.keys[dependent_position] if !dependent_position.nil?
	end

	def js_dependent_id model,options,config,field_type
		object = config[:object]
		"#{model}_#{get_dependent(config,field_type)}_#{options[:id]}"
	end

	def lumni_institution_field model,f,options,config={}


		if options[:list].nil?
			options[:list] = empty_list
		end

		major_field_id = js_dependent_id(model,options,config, 'majors')

		options[:dependent] = major_field_id
		options[:html_class] = " lumni_institutions-#{model}_#{f}_#{options[:id]}"
		lumni_dropdown_field model,f,options,config
	end

	def lumni_majors_field model,f,options,config={}

		options[:list] = empty_list
		object = config[:object]
		institution_field = get_dependent(config, 'institution')
		institution = object[institution_field]

		if !institution.nil?
			options[:list] = programs_by_institution(institution,options[:list_number])
		end

		lumni_dropdown_field( model,f,options,config.dup.except(:filter,:object))
	end


	def lumni_countries_field model,f,options,config={}
		if options[:list].nil?
			options[:list] = countriesList
		end

		region_field_id = js_dependent_id(model,options,config, 'regions')
		city_field_id = js_dependent_id(model,options,config, 'cities')

		options[:dependent] = [region_field_id,city_field_id].join(';')
		options[:html_class] = " lumni_countries-#{model}_#{f}_#{options[:id]}"
		lumni_dropdown_field model,f,options,config
	end
	def lumni_regions_field model,f,options,config={}

		if !options[:list].nil?
			options[:filter_list] = options[:list].values.first[:values]
		end

		options[:list] = empty_list
		object = config[:object]
		country_field = get_dependent(config, 'countries')
		country = object[country_field]

		if !country.nil?
			options[:list] = regionsCitiesList(country,nil,options)
		end

		city_field_id = js_dependent_id(model,options,config, 'cities')

		options[:dependent] = city_field_id
		lumni_dropdown_field( model,f,options,config.dup.except(:filter,:object))
	end
	def lumni_cities_field model,f,options,config={}

		if !options[:list].nil?
			options[:filter_list] = options[:list].values.first[:values]
		end


		options[:list] = empty_list
		filter = config[:filter]
		object = config[:object]
		country_position = filter.values.map{|v| v[:field_type]}.index('countries')
		region_position = filter.values.map{|v| v[:field_type]}.index('regions')

		if !country_position.nil? && !region_position.nil?
			country_field = filter.keys[country_position]
			region_field = filter.keys[region_position]
			country = object[country_field]
			region = object[region_field]

			if !country.nil? && !region.nil?
				options[:list] = regionsCitiesList(country,region,options)
			end
		else
			options[:list] = empty_list
		end

		lumni_dropdown_field(model,f,options,config.dup.except(:filter,:object))
	end




	def lumni_dropdown_field model,f,options,config={}



		options[:type] = options[:field_type] if options[:type].nil?
		options[:type] = 'list' if options[:type].nil?
		options = default_fields(options)

		if options[:value].class != Array
			options[:value] = options[:value].to_s.split(';')
		else
			options[:value] = options[:value].map{|value| value.to_s}
		end

		options_list = ''

		options[:list].keys.each do |group|
			begin
				tempGroupLabel = I18n.t('list.' + group.to_s, :raise => I18n::MissingTranslationData)
			rescue
				tempGroupLabel = properName(group.to_s.humanize)
			end

			options_list += content_tag(:optgroup, nil, label: tempGroupLabel) do 
				options[:list][group][:values].each_with_index do |option,index|
					concat content_tag(:option, options[:list][group][:labels].nil? ? I18n.t('list.' + option) : options[:list][group][:labels][index] ,
						value: option, selected: options[:value].include?(option.to_s))
				end
			end
		end


		legal_addition = ''
		legal_class = ''
		if options[:type] == 'legal_language'
			options[:list].keys.each do |group|
				options[:list][group][:legalText].each_with_index do |l, index|
					legal_addition += content_tag(:div,l.to_s.html_safe,id: model + '_' + f + '_' + options[:id].to_s + options[:list][group][:values][index].to_s, class: 'my-4',
						style: (options[:value].first.to_s == options[:list][group][:values][index].to_s ? nil : "display: none;"))
				end
			end
			legal_class = 'legal_dropdown'
		end

		multiple_class = 'selectpicker '
		if options[:type] == 'multiple_dropdown'
			multiple_class = ' lumni-multiple-dropdown ' 
		end
		content_tag(:select,nil,class: multiple_class + legal_class + options[:html_class].to_s,multiple: (options[:type] == 'multiple_dropdown'), 'data-style'.to_sym => 'btn-default', 'data-live-search'.to_sym => true, id: model + '_' + f + '_' + options[:id].to_s,
			name: model + '[' + f + ']' + (options[:type] == 'multiple_dropdown' ? '[]' : ''), disabled: options[:disabled], required: options[:required], hidden: options[:hidden],
			'data-none-selected-text' => options[:placeholder].nil? ? I18n.t('form.select_option') : options[:placeholder],lumni_type: options[:type],
			'data-none-results-text' => I18n.t('form.no_results'),form_key: options[:form_key],
			oninvalid: "setErrroMessage(this,'#{options[:error_text]}','#{options[:type]}')",onchange: "removeErrorMessage(this,'#{options[:type]}')",dependent: options[:dependent]) do
			concat content_tag(:option, nil, 'data-tokens'.to_sym => '')
			concat options_list.html_safe
		end + legal_addition.html_safe  
	end

	def lumni_editor_field model,f,options,config={}
		options[:type] = options[:field_type] if options[:type].nil?
		options[:type] = 'editor' if options[:type].nil?
		options = default_fields(options)

		content_tag(:hr,nil,class: 'mt-1 mb-3') +
		content_tag(:div,options[:value].nil? ? nil : options[:value].to_s.html_safe, class: 'quill-bubble-editor',id: model + '_' + f + '_' + options[:id].to_s + 'lumnieditor', starting_text: options[:placeholder].nil? ? I18n.t('form.insert_text') : options[:placeholder] ) + 
		content_tag(:input,nil,value: options[:value],hidden: true, name: model + '[' + f + ']',form_key: options[:form_key],id: model + '_' + f + '_' + options[:id].to_s) + 
		content_tag(:hr,nil,class: 'mt-1 mb-3')
	end


	def lumni_full_editor_field model,f,options,config={}
		options[:type] = options[:field_type] if options[:type].nil?
		options[:type] = 'full_editor' if options[:type].nil?
		options = default_fields(options)

		content_tag(:div,options[:value].nil? ? nil : options[:value].to_s.html_safe,class: 'lumni-jodit',id: model + '_' + f + '_' + options[:id].to_s + 'lumnifulleditor') +
		content_tag(:input,nil,value: options[:value],hidden: true, name: model + '[' + f + ']',form_key: options[:form_key],id: model + '_' + f + '_' + options[:id].to_s)
	end

	def lumni_textarea_field model,f,options,config={}
		options[:type] = options[:field_type] if options[:type].nil?
		options[:type] = 'text' if options[:type].nil?
		options = default_fields(options)

		content_tag(:textarea,options[:value],id: "textarea-container-#{f}", onload: 'addTextareaCounter()', class: "form-control autosize #{'textarea_counter' if options[:maxlength].present? }",name: model + '[' + f + ']',form_key: options[:form_key],id: model + '_' + f + '_' + options[:id].to_s,
		disabled: options[:disabled],
			maxlength: options[:maxlength],
				required: options[:required], hidden: options[:hidden], 
				oninvalid: "setErrroMessage(this,'#{options[:error_text]}','#{options[:type]}')",oninput: "removeErrorMessage(this,'#{options[:type]}')")
	end


end


