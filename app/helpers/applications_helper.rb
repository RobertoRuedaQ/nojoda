module ApplicationsHelper


	def application_general_application_table_header fields
		fields.map{|f| Application.human_attribute_name(f)}
	end

	def application_general_application_table_rows fields, applications
		total_array = []
		applications.each do |application|
			total_array += [fields.map{|field| translate_application_table_at_applicant( field,application) }]
		end
		return total_array
	end

	def translate_application_table_at_applicant field,target_record
		result = nil
		case field
		when 'id'
			result = link_to target_record.send(field), edit_application_path(target_record), target: :blank, class: 'text-primary'
		when 'status'
			value = target_record.send(field)

			result = (value.empty? || value.nil?) ? '' : I18n.t('list.' + value)
		when 'application_case'
			result = I18n.t('application.' + target_record.send(field))
		when 'last_change_at'
			value = target_record.send(field)
			result = is_valid_date?(value) ? value.strftime('%Y-%m-%d %I:%M %p') : value
		when 'disbursement_request_value'
			result = lumni_currency(target_record.resource.requested,target_record.resource.currency)
		when 'disbursement_review_button'
			result = render '/students/partial/disbursement_review_button',disbursement: target_record.resource
		when 'step'
			result = ''
		when 'destroy'
			result = link_to(I18n.t('general.destroy'),application_path(target_record),method: :delete,class: 'text-danger')
		when 'reactivate'
			if target_record.application_case == 'disbursement_request'
				if target_record.resource.disbursement_payment.any? && target_record.resource.disbursement_payment.first.status == 'payed'
					result = I18n.t('general.already_pay_not_possible_to_reactivate')
				elsif target_record.resource.disbursement_payment.empty? || (target_record.resource.disbursement_payment.any? && target_record.resource.disbursement_payment.first.status != 'payed')
					result = link_to(I18n.t('general.reactivate'),reactivate_regular_application_application_path(target_record),class: 'text-info')
				end
			else
				result = link_to(I18n.t('general.reactivate'),reactivate_regular_application_application_path(target_record),class: 'text-info')
			end
		when 'change_disbursement_request'

			if ['partially_payed', 'payed'].exclude?(target_record.resource.stored_general_status) && target_record.disbursement_request.present?
				result = ''
			end
		else
			result = target_record.send(field)
		end
		return result
	end

	def application_personal_information
		fields = {}
		fields[:first_name] = {required: true, help: I18n.t('help.name')}
		fields[:last_name] = {required: true}
		fields[:language] = {list: languageList, required: true}
		fields[:time_zone] = {list: timezoneList}
		fields[:email] = {required: true,field_type: 'email'}
		return fields
	end

	def application_contact_information
		fields = {}
		fields[:mobile] = {required: true}
		fields[:phone] = {}
		fields[:other_phone] = {}
		fields[:email] = {required: true}
		fields[:secondary_email] = {}
		return fields
	end

	def application_location_information
		fields = {}
		fields[:address1] = {}
		fields[:address2] = {}
		fields[:city] = {}
		fields[:state] = {}
		fields[:country] = {}
		return fields
	end

	def target_application_icon option
		icon_text = 'ion ion-md-options'

		case option
		when 'form'
			icon_text = 'ion ion-md-list-box'
		when 'legal_document'
			icon_text = 'ion ion-ios-albums'
		when 'questionnaire'
			icon_text = 'ion ion-ios-school'
		when 'submit'
			icon_text = 'ion ion-md-checkmark-circle-outline'
		end
		return icon_text
	end

	def generate_application_sections target_module, application
		@application = application
		@target_module = target_module
		@target_sections = target_module.cached_origination_section
		@hidden_fields = {}
		@hidden_fields[:target_module] =  target_module.id
		@hidden_fields[:application_id] = application.id
		
		case @target_module.option
		when 'form'
			render 'applications/partial/form',target_module: target_module
		when 'legal_document'
			render 'applications/partial/legal_document', target_module: target_module
		when 'questionnaire'
			@application = application
			render 'applications/partial/questionnaire', target_module: target_module
		end

	end

	def child_yes_no section, application
		options = {}
		options[:list] = yes_no_list
		content_tag(:div,class: "child_yes_no_container-#{section.id}", application: application.id, section: section.id,user: current_user.id) do 
			lumni_dropdown_field( 'child_present','boolean',options)
		end
	end

	
	def number_to_word value, language = I18n.locale
		return unless value
		
		I18n.with_locale(language) { value.to_words }.capitalize
	end
end
