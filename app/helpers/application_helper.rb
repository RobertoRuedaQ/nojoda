module ApplicationHelper
	include ActiveSupport::Inflector

	def simulating?
		session[:original_account].present?
	end

	
	def original_account
		# account simulating
		return User.cached_find(session[:original_account])
	end

	def sidebar_behavior
		if user_signed_in? && current_user.student?
			@response = 'layout-navbar-fixed'
		else
			@response = 'layout-collapsed'
		end
		@response
	end

	def staging?
		current_subdomain.include?('lumni.org') || current_subdomain.include?('localhost')
	end

	def mexico?
		current_company.id == 6
	end

	def lumni_month target_number
		properName I18n.t('date.abbr_month_names')[target_number]
	end
	
	def properName string
		proper = ''
		string.downcase.split(' ').each do |s|
			s[0] = s[0].capitalize
			proper += s + ' '
		end
		proper
	end

	def user_name
		properName(current_user.name)
	end

	def current_page_path?(p)
    	request.path.start_with? p
	end

	def lumni_date input
		unless input.nil?
			I18n.localize input, format: :long
		end
	end


	def lumni_short_date input
		unless input.nil?
			properName(I18n.localize input, format: :lumni_short)
		end
	end

	def lumni_full_date imput
		unless input.nil?
			I18n.localize input, format: :full
		end
	end

	def is_valid_date?(d)
		Date.valid_date? *"#{Date.strptime(d,"%m/%d/%Y")}".split('-').map(&:to_i) rescue nil
	end

	def lumni_currency input, currency = nil
		unless input.nil?
			if currency.nil?
				currency = current_company.cached_currency
			end
			begin
				precision = current_company.cached_precision.to_i
				
			rescue Exception => e
				precision = 1			
			end
			number_to_currency(input,unit: I18n.t("currency.unit.#{currency}"),format: I18n.t("currency.format.#{currency}"),precision: precision, separator: ".", delimiter: ",")
		end
	end

	def current_company
		if cookies[:current_company_id].present? 
			Company.cached_find(cookies[:current_company_id])
		else
			Company.cached_current_company(current_subdomain) 
		end
	end

	def current_holding
		current_company.cached_holding
	end

	def my_companies
		current_company.cached_my_companies
	end

	def is_lumni_portal?
		current_subdomain == 'www.lumniportal.net'
	end

	def holding_countries
		Country.joins(company: [fund: :funding_opportunities]).includes(:company).where(countries: { companies: {id: current_company.my_companies.ids}}).where(show_in_home: true).order(:name).distinct
	end

	def current_subdomain
		request.original_url.split('/')[2]
	end

	def true?(text)
		validation = text == 'true'
		return validation
	end

	def sf_date(date)
		unless date.nil?
			d = date.split('-')
			tempDate = (d[2] + '/' + d[1] + '/' + d[0]).to_s
		end
	end

	def search_value_in_a_list value, list
		target_array = list.values.map{|v| v.values}
		values_array = target_array.map{|v| v.first}.flatten
		labels_array = target_array.map{|v| v.last}.flatten

		values_array.index(value).nil? ? '' : labels_array[values_array.index(value)]
	end


	def disbursement_case_translation(value)
	

	end

	def ransack_params_value(atribute)
		return  if params[:q].nil?
		params[:q][atribute]
	end

	def ransack_collection_for_select(collection, text_attribute, id_attribute, default_value, item_translated = false)
		c = collection.map do |item|
			if item_translated
				[I18n.t("application.#{item}"), item]
			else
				[item.send(text_attribute).titleize.to_s, item.send(id_attribute)]
			end
		end

		c.insert(0, [I18n.t('none'), ''])

		return options_for_select(c, ransack_params_value(default_value))
	end

	def translate_disbursement_case(appl)
		return 'N/A' unless appl.application_case == 'disbursement_request'

		I18n.t("disbursement.#{appl.disbursement_case}")
	end

	def translate_disbursement_request_case(appl)
		return 'N/A' unless appl.application_case == 'disbursement_request'
		return 'N/A' unless appl.requested_disbursement_case.present?

		I18n.t("application.#{appl.requested_disbursement_case}")
	end

	def find_in_collection(collection, to_find)
		collection.where(to_find)
	end
end
