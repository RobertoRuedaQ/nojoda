module IncomeInformationsHelper

	## Stduent View
	def income_information_student_fields_table
		['company_name','total_income','currency', 'start_date','end_date','edit']
	end

	def income_information_student_header_table
		income_information_student_fields_table.map{|field| income_information_student_tranlator_header field}
	end

	def income_information_student_rows_table income_sources
		result = []
		income_sources.each do |income_source|
			result += [income_information_student_fields_table.map{|field| income_information_student_translator_rows income_source, field}]
		end
		return result

	end


	## Team View
	def student_income_information_fields_table
		['id','company_name','position','total_income','currency', 'income_in_local_currency', 'exchange_rates','income_case', 'status','fix_income','variable_income','start_date','end_date','certificate']
	end

	def student_income_information_header_table
		student_income_information_fields_table.map{|field| income_information_student_tranlator_header field}
	end

	def student_income_information_rows_table income_sources
		result = []
		income_sources.each do |income_source|
			result += [student_income_information_fields_table.map{|field| income_information_student_translator_rows income_source, field}]
		end
		return result

	end

	## General Classes


	def income_information_student_tranlator_header field
		case field
		when 'company_name'
			result = IncomeInformation.human_attribute_name('income_source')
		else
			result = IncomeInformation.human_attribute_name(field)
		end
		return result

	end

	def income_information_student_translator_rows income_source, field
		['certificate']
		case field
		when 'company_name'
			if !income_source.income_case.nil?
				result = income_source.company_name.nil? ? I18n.t("list.#{income_source.income_case.gsub ' ', ''}") : income_source.company_name
			else
				result = ''
			end
		when 'start_date', 'end_date'
			result = lumni_date income_source.send(field)
		when 'fix_income', 'variable_income','total_income', 'income_in_local_currency'
			result = lumni_currency income_source.send(field), income_source.currency
		when 'status'
			result = I18n.t("general.#{income_source.send(field)}")
		when 'certificate'
			if income_source.income_certificate.attached?
				file_url = url_for(income_source.income_certificate)
				result = link_to I18n.t('general.certificate'), file_url, class: 'text-primary', target: '_blank'
			else
				result = 'empty'
			end
		when 'edit'
			result = edit_button(income_source) if income_source.can_be_edited?
		else
			result = income_source.send(field)
		end
		return result
	end

	def edit_button(income_source)
		content_tag :div, link_to( I18n.t('general.edit'), edit_record_income_information_path(income_source), class: 'btn btn-primary btn-sm'), class: 'text-center'
	end

	def company_chile?
		current_company.id == 5
	end

	def chilenian_income_information?(cached_form_template)
		company_chile? && cached_form_template.object == 'IncomeInformation'
	end

	def chile_income_template(target_template)
		chile_income_template = target_template
		if target_template.class == Hash
			chile_income_template[:variable_income][:custom_label] = 'horas extras, asignaciones, viáticos entre otros' unless chile_income_template[:variable_income].nil?
			chile_income_template[:fix_income][:custom_label] = 'Sueldo base mas gratificación' unless chile_income_template[:fix_income].nil?
			chile_income_template
		else
			chile_income_template.first[:variable_income][:custom_label] = 'horas extras, asignaciones, viáticos entre otros' unless chile_income_template.first[:variable_income].nil?
			chile_income_template.first[:fix_income][:custom_label] = 'Sueldo base mas gratificación' unless chile_income_template.first[:fix_income].nil?
			chile_income_template
		end
	end

	def disbursement_request_case(cached_form_template)
		cached_form_template.object == 'DisbursementRequest'
	end

	def student_academic_information_case(cached_form_template,application)
		cached_form_template.object == 'StudentAcademicInformation' && application.application_case != 'origination'
	end

	def student_academic_information_origination_case(cached_form_template,application)
		cached_form_template.object == 'StudentAcademicInformation' && application.application_case == 'origination'
	end

	def student_academic_information_template(target_template, target_info)
		if target_template.first[:current_term].present?
		student_academic_information_template = target_template
			list = student_academic_information_template.first[:current_term][:list].first
			list_hash = list.second
			top = (target_info.current_term).to_s
			new_values_and_labels = list_hash[:values].reject{|e| e.to_i < top.to_i}
			student_academic_information_template.first[:current_term][:list].first.second[:values] = new_values_and_labels
			student_academic_information_template.first[:current_term][:list].first.second[:labels] = new_values_and_labels
			student_academic_information_template
		else
			target_template
		end
	end

	def origination_academic_information_template(target_template, target_info)
		student_academic_information_template = target_template
		if target_template.first[:disbursement_value].present?
			student_academic_information_template.first[:disbursement_value][:max] = target_info.funding_opportunity.funding_disbursement.max_funding_by_disbursement
			student_academic_information_template
		else
			student_academic_information_template
		end
	end

	def income_information_template(target_template, target_info)
		template = target_template

		if simulating? || current_user.staff?
			if target_template.class == Hash
				template[:presumptive_income] = presumptive_income_field
			else
				template.first[:presumptive_income] = presumptive_income_field
			end
		else
			if target_template.class == Hash
				template.delete(:presumptive_income) if template[:presumptive_income].present?
			else
				template.first.delete(:presumptive_income) if template.first[:presumptive_income].present?
			end
		end
		
		return template
	end

	def presumptive_income_field
		{
			field_type: 'boolean',
			grid: 4,
			custom_label: '¿Es Renta Presuntiva?'
		}
	end

	def disbursement_request_template(target_template, target_info)
		if target_template.first[:disbursement_value].present?
			disbursement = target_info.application.resource
			if (disbursement.disbursement_number == 1 && disbursement.disbursement_case == 'tuition') || disbursement.disbursement_case == 'living_expenses'
				disbursement_request_template = target_template.first
				next_disbursement = next_disbursement(disbursement)
				total_amount = []
				total_amount << disbursement.student_value.to_f
				total_amount << next_disbursement.available_for_request_in_advance unless next_disbursement.nil?
				disbursement_request_template[:disbursement_value][:max] = total_amount.reduce(:+)
				disbursement_request_template
			else
				disbursement_request_template = target_template.first
				total_amount = []
				previous_disbursement = previous_disbursement(disbursement)
				next_disbursement = next_disbursement(disbursement)
				total_amount << disbursement.student_value.to_f
				total_amount << previous_disbursement.free.to_f unless previous_disbursement.nil?
				total_amount << next_disbursement.available_for_request_in_advance unless next_disbursement.nil?				
				disbursement_request_template[:disbursement_value][:max] = total_amount.reduce(:+)
				disbursement_request_template
			end
		else
			target_template
		end
	end
	
	def previous_disbursement(disbursement)
		Disbursement.where(funding_option_id: disbursement.funding_option_id, disbursement_case: disbursement.disbursement_case, student_academic_information_id: disbursement.student_academic_information_id, disbursement_number: disbursement.disbursement_number - 1).last
	end

	def next_disbursement(disbursement)
		Disbursement.where(funding_option_id: disbursement.funding_option_id, disbursement_case: disbursement.disbursement_case, student_academic_information_id: disbursement.student_academic_information_id, disbursement_number: disbursement.disbursement_number + 1).last
	end

	def university_grades_form?(cached_form_template)
		cached_form_template.object == 'UniversityGrade'
	end

	def university_grades_template(target_template, target_info)
		university_grades_template = target_template
		if target_info.present? && university_grades_template.first[:disbursement_id].present?
			student = target_info.student_academic_information.user
			university_grades_template.first[:disbursement_id][:list] = {values:disbursement_university_grade_list(student)}
		end
		university_grades_template
	end

	def editing_income_template(target_template)
		editing_income_template = target_template
		target_template[0].keys.each do |key|
			if key != :end_date
				editing_income_template[0][key][:disabled] = true
			end
		end
		editing_income_template
	end

end
