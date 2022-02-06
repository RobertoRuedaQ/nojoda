module SidebarHelper
	def lumni_sidebar
		if user_signed_in?
			fields = sidebar_fields
			roles = current_user.cached_role_names
			fields.keys.each do |key|
				if !fields[key][:controllers].nil?
					fields[key][:controllers].each do |controller|
						if !roles.include?(controller + '_view')
							fields[key][:controllers] = fields[key][:controllers] - [controller]
						end
					end
				end
				if fields[key][:controllers].nil? || fields[key][:controllers].count == 0
					fields.except!(key)
				end
			end

			status = ''
			sidebar_menu = ''

			fields.keys.each do |field|
				if !fields[field].nil? && !fields[field][:controllers].nil?
					subMenu = content_tag(:ul,nil,class: 'sidenav-menu') do
						fields[field][:controllers].each do |c|
							concat content_tag(:li,content_tag(:a, eval(c.singularize.camelize).model_name.human(count: 1) ,class: 'sidenav-link', href: '/' + c),class: "sidenav-item #{c == params[:controller] ? ' active' : ''}" ) 
						end
					end
				else
					subMenu = ''
				end

				if !fields[field].nil? && !fields[field][:controllers].nil?
					if fields[field][:controllers].include?(params[:controller])
						status = " active open "
					else
						status = ''
					end
				else
					status = ''
				end
				sidebar_menu += content_tag(:li,subMenu ,class: 'sidenav-item' + status) do
					concat content_tag(:a, fields[field][:icon].nil? ? '' : content_tag(:i, nil, class: 'sidenav-icon ' + fields[field][:icon]).to_s +
						I18n.t('mains.' + field.to_s),href: 'javascript:void(0)', class: 'sidenav-link sidenav-toggle')
					concat subMenu
				end
			end

			return sidebar_menu.html_safe

		end

	end
end

