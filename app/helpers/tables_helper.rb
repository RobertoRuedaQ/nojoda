module TablesHelper
	def createTable(object,fields,options = {})
		@object = object
		if !current_user.allowed_create?(params)
			options[:new] = false
		end

		@headerText, @tableText = createTableElements(@object.to_a,fields,options)
		render '/forms/table',table_options: options
	end

	def createTableForm(object,fields,options = {})
		@listRecords = object
		@options = options
		@fields = fields
		@html = options[:html]

		@headerText, @tableText = createTableElements(object,fields,options)

		render '/forms/tableForms'
	end

	def createTableElements(object,fields,options)
		headerText = ''
		fields.keys.each do |f|
			if object.count > 0
				if object.first.class.to_s == 'Audited::Audit'
					headerText += content_tag(:th, I18n.t('audits.' + f.to_s))
				else
					headerText += content_tag(:th, object.first.class.human_attribute_name(f))
				end
			else
				headerText += content_tag(:th, User.human_attribute_name(f))
			end
		end

		if !options[:actions].nil? && options[:actions] == true
			# Actions column
			headerText += content_tag(:th)
		end

	    tableText = ''

	    if !object.nil?
	    	if options[:current_values]
	    		object.potential_not_approved_version
	    	end

				object.each_with_index do |o|
		    	store_fields = o.class.all_active_storage_fields unless o.class.name.to_s == "Audited::Audit"
		    	tableText += content_tag(:tr, class: 'odd gradeX') do 
		    		fields.keys.each do |f|

		    			if f.to_s == 'id' && fields[f][:target_id].nil? && (options[:idlink].nil? || options[:idlink] == true)
		    				concat content_tag(:td, content_tag(:a, table_values(o,f,current_values: options[:current_values],list:fields[f][:list]),href: "/#{(options[:custom_controller].nil? ? params[:controller] : options[:custom_controller])}/#{o.id}/edit") )
		    			elsif !fields[f][:controller].nil? && !fields[f][:action].nil? && !fields[f][:target_id].nil?
		    				concat content_tag(:td, content_tag(:a, table_values(o,f,current_values: options[:current_values],list:fields[f][:list]),href: "/#{fields[f][:controller]}/#{o.send(fields[f][:target_id])}/#{fields[f][:action]}") )
		    			elsif store_fields.present? && store_fields.include?(f.to_s)

							if o.send(f).is_a?(ActiveStorage::Attached::Many) && o.send(f).attached?
								target_urls = []
								o.send(f).each do |target_file|
									target_urls << url_for(target_file)
								end
							elsif o.send(f).attached?
								target_urls = [url_for(o.send(f))]
							end
							concat content_tag :td, lumni_active_storage_links(target_urls)
		    			elsif f.to_s == 'check'
		    				concat content_tag(:td, render('/forms/partial/check',object: o))
		    			elsif fields[f][:field_type] == 'currency'
							begin
								concat content_tag(:td, lumni_currency(table_values(o,f,current_values: options[:current_values],list:fields[f][:list]).to_f, o.currency))
		    				rescue Exception => e
								concat content_tag(:td, lumni_currency(table_values(o,f,current_values: options[:current_values],list:fields[f][:list]).to_f))
		    				end		    				
		    			elsif fields[f][:field_type] == 'percentage'
	    					concat content_tag(:td, table_values(o,f,current_values: options[:current_values],list:fields[f][:list]).to_f.to_s + '%')
		    			else
	    					concat content_tag(:td, table_values(o,f,current_values: options[:current_values],list:fields[f][:list]))
		    			end
		    		end
					if !options[:actions].nil? && options[:actions] == true
					    concat content_tag(:td, 
					    	smallIon('Edit', 'create') + 
					    	content_tag(:div, class: 'btn-group') do
					    		concat smallIon('Actions', 'settings')
					    		concat content_tag(:div, 
					    			content_tag( :a, 'View' ,class: 'dropdown-item') +
					    			content_tag( :a, 'Remove' ,class: 'dropdown-item',href: (options[:custom_controller].nil? ? params[:controller] : options[:custom_controller]).downcase + '/' + o.id.to_s,'data-method'.to_sym => 'delete',  ), 
					    			class: "dropdown-menu dropdown-menu-right")
					    	end
					    	
					    	)
	    			end		 
		    	end
		    end
		end

		return [headerText,tableText]
	end


	def lumni_active_storage_links target_urls
		links_text = ''
		if target_urls.present?
			target_urls.each do |url|
				links_text += content_tag(:a, url.split('/').last,href: url, class: 'text-primary')
			end
		end
		links_text.html_safe
	end


	def smallIon(title, ion)
		content_tag(:button,content_tag(:i,'', class: 'ion ion-md-' + ion), type: 'button', 
			    	class: 'btn btn-default btn-xs icon-btn md-btn-flat dropdown-toggle hide-arrow user-tooltip mx-1','data-toggle'.to_sym  => "dropdown")
	end

	def hash_to_list( hash, options={})
		content_tag(:ul) do
			hash.keys.each do |h|
				if options[:field].present? && options[:field] == 'audited_changes'
					content_text = hash[h.to_sym].nil? ? '' : I18n.t('audits.from') + audited_text(hash,h,0).to_s + I18n.t('audits.to') + audited_text(hash,h,1).to_s
				else
					content_text = hash[h.to_sym].to_s 
				end


				concat content_tag(:li,
				content_tag(:strong,options[:object].present? ? options[:object].human_attribute_name(h) : h ) + ': ' + content_text  )
			end
		end
		
	end

	def audited_text hash, key, number

		if hash[key.to_sym][number].class.to_s == 'ActiveSupport::TimeWithZone'
			lumni_date(hash[key.to_sym][number])
		else
			hash[key.to_sym][number]
		end
	end

	def table_values object, field, options={}

		input = object.send(field)

		if !options[:list].nil?

			list = options[:list]
			values = list.keys.map{|list_key| list[list_key][:values]}.flatten
			labels = list.keys.map{|list_key| list[list_key][:labels]}.flatten
			target_item =  values.index(input)
			if target_item.nil?
				input.to_s
			else
				labels[target_item]
			end
		elsif input.class.to_s == 'ActiveSupport::TimeWithZone'
			lumni_date input
		elsif input.class.to_s == 'User'
			input.name
		elsif input.is_a? Hash
			if field == "audited_changes"
				hash_to_list(input,object: object.auditable.class, field: field)
			else
				hash_to_list(input)
			end
		else
			input.to_s
		end
	end


end
