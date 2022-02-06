module LegalLanguageListHelper
	def funding_opportunity_criteria company_id,target_user
		list = {}
		tempFundingOpportunity = FundingOpportunity.joins(:eligibility_criteria,fund: :company).where(status: 'in_progress',funds:{companies:{id: company_id}},legal_documents: {document_type: "eligibility_criteria"}).kept
		list[:available_funding_opportunities] = {values: tempFundingOpportunity.ids, labels: tempFundingOpportunity.map{|d| d.name} , 
										legalText: tempFundingOpportunity.map{|d| adjust_legal_language( target_user, d.eligibility_criteria.body)}}
		return list
	end

	def create_legal_document_form legal_document_id, options={}
		@options = options
		@legal_match = LegalMatch.new()
		@legal_document = LegalDocument.cached_find(legal_document_id)
	
		if options[:promissory_note_id]
			@promissory_note_legal_document = LegalDocument.cached_find(options[:promissory_note_id]) 
		end
		render "legal_matches/partial/#{@legal_document.validation_method}"
	end

	def adjust_legal_language target_user, legal_body, options={}
		if options[:application].present?
			target_application = options[:application]
		else
			target_application = target_application
		end

		## Legal Document Info
		legal_body = legal_body.to_s
		legal_body.gsub! '##type_student_document', I18n.t("list.#{target_user.personal_information.document_type.to_s}")
		legal_body.gsub! '##identity_number', target_user.personal_information.identification_number.to_s

		##date
		legal_body.gsub! '##today', lumni_date(Date.today)
		legal_body.gsub! '##program_start_date', (lumni_date(target_user.funded_programs.first.program_start_date) || '') unless target_user.funded_programs.first.nil?
		legal_body.gsub! '##current_year', Time.zone.now.year.to_s

		##lumni_legal_representative
		legal_body.gsub! '##lumni_legal_representative', "Sylvia Milena Ortiz"
		legal_body.gsub! '##document_lumni_legal_representative', "C.C. 63.507.080 de Bucaramaga"
		legal_body.gsub! '##lumni_address_col', "Avenida el dorado No.68c – 61 oficina 204"
		legal_body.gsub! '##mobile_lumni', '322 3603599'
		##new_ammendment tags
		if target_user.active_isa.any?
			agreements = target_user.active_isa.first.payment_agreement
			if agreements.any?
				normalization_agreement = agreements.select{|a| a.agreement_case == 'normalization' && a.status == "valid"}.last
				legal_body.gsub! '##payment_agreetment_value', (lumni_currency(normalization_agreement.cuota_value.to_s) || '') unless normalization_agreement.nil?
			end
		end
		
		if target_user.ongoing_application.present? && target_user.ongoing_application.funding_opportunity.present? &&target_user.ongoing_application.funding_opportunity.payment_config.present?
			payment_config = target_user.ongoing_application.funding_opportunity.payment_config
			legal_body.gsub! '##conciliation_rate', payment_config.conciliation_rate.to_s
			legal_body.gsub! '##normalization_rate', payment_config.normalization_rate.to_s
			legal_body.gsub! '##termination_rate', payment_config.termination_rate.to_s
			legal_body.gsub! '##arrears_rate', payment_config.arrears_rate.to_s
			legal_body.gsub! '##nominal_penalty', payment_config.nominal_penalty.to_s
		end

		if target_user.ongoing_application.present? && target_user.ongoing_application.funding_opportunity.present? &&target_user.ongoing_application.funding_opportunity.funding_disbursement.present?
			funding_disbursement = target_user.ongoing_application.funding_opportunity.funding_disbursement
			legal_body.gsub! '##max_total_fundinding_value', (lumni_currency(funding_disbursement.max_total_fundinding_value.to_s) || '')
      legal_body.gsub! '##max_funding_by_disbursement', (lumni_currency(funding_disbursement.max_funding_by_disbursement.to_s) || '')
			legal_body.gsub! '##max_funding_months', funding_disbursement.max_funding_months.to_s
      legal_body.gsub! '##living_expenses_value', (lumni_currency(funding_disbursement.living_expenses_value.to_s) || '') 
      legal_body.gsub! '##living_expenses_periodicity', funding_disbursement.living_expenses_periodicity.to_s 
      legal_body.gsub! '##max_tuition_percentage', funding_disbursement.max_tuition_percentage.to_s
		end

		## Academic Record
		result = nil
		academic = target_user.funded_academic_information
		if academic.present? && !academic.major_id.nil?
			result = target_user.funded_academic_information.major.name.to_s
		end

		legal_body.gsub! '##major', properName(result.to_s)


		result = nil
		egress_date = target_user.funded_academic_information
		if egress_date.present?
			result = target_user.funded_academic_information.expected_graduation_date.to_s
		end
		legal_body.gsub! '##egress_date', result.to_s
		

		result = nil
		academic = target_user.funded_academic_information
		if academic.present? && !academic.institution_id.nil?
			result = target_user.funded_academic_information.institution.name
		end
		legal_body.gsub! '##educational_entity', properName(result.to_s)


		## Students Info
		legal_body.gsub! '##full_name', target_user.name.to_s
		legal_body.gsub! '##student_address', properName(target_user.location.address1.to_s)
		legal_body.gsub! '##student_birth_date', target_user.personal_information.birthday.to_s
		legal_body.gsub! '##marital_status_student', I18n.t("list.#{target_user.personal_information.marital_status.to_s}")
		legal_body.gsub! '##student_mobile2', target_user.contact_info.other_phone.to_s
		legal_body.gsub! '##student_mobile1', target_user.contact_info.mobile.to_s
		legal_body.gsub! '##email_student', target_user.contact_info.contact_email.to_s
		legal_body.gsub! '##student_email2', target_user.contact_info.secondary_email.to_s 
		legal_body.gsub! '##student_municipality', target_user.location.municipality.to_s 
		legal_body.gsub! '##student_neighborhood', target_user.location.neighborhood.to_s 
		legal_body.gsub! '##student_zip_code', target_user.location.zip_code.to_s 
		legal_body.gsub! '##student_rfc', target_user.personal_information.rfc.to_s
		legal_body.gsub! '##student_nationality', (target_user.personal_information.nationality.to_s || '')
		legal_body.gsub! '##student_curp_id', (target_user.personal_information.curp_id.to_s || '')
		legal_body.gsub! '##student_curp_document', (target_user.personal_information.curp_document.to_s || '')

		legal_body.gsub! '##student_country', (target_user.location.country&.label&.capitalize || '') 

		if !target_user.location.state_id.nil?
			legal_body.gsub! '##student_state', target_user.location.state.label
		end

		if !target_user.location.city_id.nil?
			legal_body.gsub! '##student_city', target_user.location.city.label
		end

		##modeling
		if target_application.present? && target_application.funding_option.present? && target_application.funding_option.selected.first.present? && target_application.funding_option.selected.first.modeling_fixed_condition.present?
			modeling_fixed_condition = target_application.funding_option.selected.first.modeling_fixed_condition
			top_amount = modeling_fixed_condition.cap_value
			funded_student_amount =target_application.funding_option.selected.first.funded_student_amount.to_f
			isa_term = target_application.funding_option.selected.first.isa_term
			legal_body.gsub! '##top_amount', (top_amount.to_s || '') 
			legal_body.gsub! '##in_letter_top_amount', ( number_to_word(top_amount) || '')
			legal_body.gsub! '##minimun_amount_for_repayment', (lumni_currency(modeling_fixed_condition.threshold.to_s) || '')
			legal_body.gsub! '##maximun_return', lumni_currency(top_amount - funded_student_amount)
			legal_body.gsub! '##fee_payment', lumni_currency(top_amount / isa_term )
		end


		## General Information

		legal_body.gsub! '##company_mail', target_user.company.contact_info.contact_email.to_s  


		# Guardian Information

		result = nil
		guardian = target_user.reference.select{|ref| ref.guardian_check == true}.first
		if !guardian.nil?
			
			guardian.attributes = translate_approval_input(guardian)

			result = guardian.name.to_s
			legal_body.gsub! '##acudient_name', result.to_s

			result = guardian.identification_number.to_s
			legal_body.gsub! '##acudient_document_number', result.to_s

			result = guardian.reference_email.to_s
			legal_body.gsub! '##acudient_mail', result.to_s
		
			result = I18n.t("list.#{guardian.indentification_case.to_s}")
			legal_body.gsub! '##type_acudient_document', result.to_s
		
			result = guardian.mobile.to_s
			legal_body.gsub! '##acudient_mobile1', result.to_s
		
			result = guardian.other_phone.to_s
			legal_body.gsub! '##acudient_mobile2', result.to_s

			result = guardian.phone.to_s
			legal_body.gsub! '##acudient_phone', result.to_s

			result = guardian.municipality.to_s
			legal_body.gsub! '##acudient_municipality', result.to_s

			result = guardian.neighborhood.to_s
			legal_body.gsub! '##acudient_neighborhood', result.to_s

			result = guardian.zip_code.to_s
			legal_body.gsub! '##acudient_zip_code', result.to_s

			result = guardian.address_1.to_s
			legal_body.gsub! '##acudient_address_1', result.to_s

			result = guardian.address_2.to_s
			legal_body.gsub! '##acudient_address_2', result.to_s

			result = guardian.rfc.to_s
			legal_body.gsub! '##acudient_rfc', result.to_s
			legal_body.gsub! '##acudient_nationality', (guardian.nationality.to_s || '')
			legal_body.gsub! '##acudient_curp_id', (guardian.curp_id.to_s || '')
			legal_body.gsub! '##acudient_curp_document', (guardian.curp_document.to_s || '')
			legal_body.gsub! '##acudients_info', render("/legal_documents/partial/acudient_info", guardian: guardian)



			legal_body.gsub! '##acudient_country', (guardian.country&.label&.capitalize || '')

			if !guardian.state_id.nil?
				result = guardian.state.label.to_s
				legal_body.gsub! '##acudient_state', result.to_s
			end

			if !guardian.city_id.nil?
				result = guardian.city.label.to_s
				legal_body.gsub! '##acudient_city', result.to_s
			end
		end

			

		# Familiar Reference Information

		result = nil
		familiar_reference = target_user.reference.find_by(reference_case:["familiar_reference"],row: 1)
		if !familiar_reference.nil?
			familiar_reference.attributes = translate_approval_input(familiar_reference)
			result = familiar_reference.name.to_s
			legal_body.gsub! '##second_familiar_reference_name', result.to_s

			result = familiar_reference.identification_number.to_s
			legal_body.gsub! '##second_familiar_reference_document_number', result.to_s

			result = familiar_reference.reference_email.to_s
			legal_body.gsub! '##second_familiar_reference_mail', result.to_s
		
			result = I18n.t("list.#{familiar_reference.indentification_case.to_s}")
			legal_body.gsub! '##type_familiar_reference_document', result.to_s
		
			result = familiar_reference.mobile.to_s
			legal_body.gsub! '##second_familiar_reference_mobile1', result.to_s
		
			result = familiar_reference.other_phone.to_s
			legal_body.gsub! '##second_familiar_reference_mobile2', result.to_s

			result = familiar_reference.phone.to_s
			legal_body.gsub! '##second_familiar_reference_phone', result.to_s

			result = familiar_reference.municipality.to_s
			legal_body.gsub! '##second_familiar_reference_municipality', result.to_s

			result = familiar_reference.neighborhood.to_s
			legal_body.gsub! '##second_familiar_reference_neighborhood', result.to_s

			result = familiar_reference.zip_code.to_s
			legal_body.gsub! '##second_familiar_reference_zip_code', result.to_s

			result = familiar_reference.address_1.to_s
			legal_body.gsub! '##second_familiar_reference_address_1', result.to_s

			result = familiar_reference.address_2.to_s
			legal_body.gsub! '##second_familiar_reference_address_2', result.to_s

			result = familiar_reference.rfc.to_s
			legal_body.gsub! '##second_familiar_reference_rfc', result.to_s

			if !familiar_reference.country_id.nil?
				result = familiar_reference.country.label.to_s
				legal_body.gsub! '##second_familiar_reference_country', result.to_s
			end

			if !familiar_reference.state_id.nil?
				result = familiar_reference.state.label.to_s
				legal_body.gsub! '##second_familiar_reference_state', result.to_s
			end

			if !familiar_reference.city_id.nil?
				result = familiar_reference.city.label.to_s
				legal_body.gsub! '##second_familiar_reference_city', result.to_s
			end

		else
			# the conditional guardian may be a familiar reference or a guardian
			guardian = target_user.reference.find_by(reference_case:["guardian"],row: 0)
			if !guardian.nil?
				guardian.attributes = translate_approval_input(guardian)

				result = guardian.name.to_s
				legal_body.gsub! '##second_familiar_reference_name', result.to_s

				result = guardian.identification_number.to_s
				legal_body.gsub! '##second_familiar_reference_document_number', result.to_s
	
				result = guardian.reference_email.to_s
				legal_body.gsub! '##second_familiar_reference_mail', result.to_s
			
				result = I18n.t("list.#{guardian.indentification_case.to_s}")
				legal_body.gsub! '##type_familiar_reference_document', result.to_s
			
				result = guardian.mobile.to_s
				legal_body.gsub! '##second_familiar_reference_mobile1', result.to_s
			
				result = guardian.other_phone.to_s
				legal_body.gsub! '##second_familiar_reference_mobile2', result.to_s

				result = guardian.phone.to_s
				legal_body.gsub! '##second_familiar_reference_phone', result.to_s

				result = guardian.municipality.to_s
				legal_body.gsub! '##second_familiar_reference_municipality', result.to_s

				result = guardian.neighborhood.to_s
				legal_body.gsub! '##second_familiar_reference_neighborhood', result.to_s

				result = guardian.zip_code.to_s
				legal_body.gsub! '##second_familiar_reference_zip_code', result.to_s

				result = guardian.address_1.to_s
				legal_body.gsub! '##second_familiar_reference_address_1', result.to_s

				result = guardian.address_2.to_s
				legal_body.gsub! '##second_familiar_reference_address_2', result.to_s

				result = guardian.rfc.to_s
				legal_body.gsub! '##second_familiar_reference_rfc', result.to_s

				if !guardian.country_id.nil?
					result = guardian.country.label.to_s
					legal_body.gsub! '##second_familiar_reference_country', result.to_s
				end

				if !guardian.state_id.nil?
					result = guardian.state.label.to_s
					legal_body.gsub! '##second_familiar_reference_state', result.to_s
				end

				if !guardian.city_id.nil?
					result = guardian.city.label.to_s
					legal_body.gsub! '##second_familiar_reference_city', result.to_s
				end

			end
		end


		# Familiar Reference Information

		result = nil
		familiar_reference = target_user.reference.where('reference_case = ? and first_name != ?', 'familiar_reference', '').order(:row).first

		if !familiar_reference.nil?
			familiar_reference.attributes = translate_approval_input(familiar_reference)
			result = familiar_reference.name.to_s

			legal_body.gsub! '##familiar_reference_name', result.to_s

			result = familiar_reference.identification_number.to_s
			legal_body.gsub! '##familiar_reference_document_number', result.to_s

			result = familiar_reference.reference_email.to_s
			legal_body.gsub! '##familiar_reference_mail', result.to_s
		
			result = I18n.t("list.#{familiar_reference.indentification_case.to_s}")
			legal_body.gsub! '##type_familiar_reference_document', result.to_s
		
			result = familiar_reference.mobile.to_s
			legal_body.gsub! '##familiar_reference_mobile1', result.to_s
		
			result = familiar_reference.other_phone.to_s
			legal_body.gsub! '##familiar_reference_mobile2', result.to_s

			result = familiar_reference.phone.to_s
			legal_body.gsub! '##familiar_reference_phone', result.to_s

			result = familiar_reference.municipality.to_s
			legal_body.gsub! '##familiar_reference_municipality', result.to_s

			result = familiar_reference.neighborhood.to_s
			legal_body.gsub! '##familiar_reference_neighborhood', result.to_s

			result = familiar_reference.zip_code.to_s
			legal_body.gsub! '##familiar_reference_zip_code', result.to_s

			result = familiar_reference.address_1.to_s
			legal_body.gsub! '##familiar_reference_address_1', result.to_s

			result = familiar_reference.address_2.to_s
			legal_body.gsub! '##familiar_reference_address_2', result.to_s

			result = familiar_reference.rfc.to_s
			legal_body.gsub! '##familiar_reference_rfc', result.to_s

			if !familiar_reference.country_id.nil?
				result = familiar_reference.country.label.to_s
				legal_body.gsub! '##familiar_reference_country', result.to_s
			end

			if !familiar_reference.state_id.nil?
				result = familiar_reference.state.label.to_s
				legal_body.gsub! '##familiar_reference_state', result.to_s
			end

			if !familiar_reference.city_id.nil?
				result = familiar_reference.city.label.to_s
				legal_body.gsub! '##familiar_reference_city', result.to_s
			end

		else
			# the conditional guardian may be a familiar reference or a guardian
			guardian = target_user.reference.find_by(reference_case:["guardian"],row: 0)
			if !guardian.nil?
				guardian.attributes = translate_approval_input(guardian)

				result = guardian.name.to_s
				legal_body.gsub! '##familiar_reference_name', result.to_s

				result = guardian.identification_number.to_s
				legal_body.gsub! '##familiar_reference_document_number', result.to_s
	
				result = guardian.reference_email.to_s
				legal_body.gsub! '##familiar_reference_mail', result.to_s
			
				result = I18n.t("list.#{guardian.indentification_case.to_s}")
				legal_body.gsub! '##type_familiar_reference_document', result.to_s
			
				result = guardian.mobile.to_s
				legal_body.gsub! '##familiar_reference_mobile1', result.to_s
			
				result = guardian.other_phone.to_s
				legal_body.gsub! '##familiar_reference_mobile2', result.to_s

				result = guardian.phone.to_s
				legal_body.gsub! '##familiar_reference_phone', result.to_s

				result = guardian.municipality.to_s
				legal_body.gsub! '##familiar_reference_municipality', result.to_s

				result = guardian.neighborhood.to_s
				legal_body.gsub! '##familiar_reference_neighborhood', result.to_s

				result = guardian.zip_code.to_s
				legal_body.gsub! '##familiar_reference_zip_code', result.to_s

				result = guardian.address_1.to_s
				legal_body.gsub! '##familiar_reference_address_1', result.to_s

				result = guardian.address_2.to_s
				legal_body.gsub! '##familiar_reference_address_2', result.to_s

				result = guardian.rfc.to_s
				legal_body.gsub! '##familiar_reference_rfc', result.to_s

				if !guardian.country_id.nil?
					result = guardian.country.label.to_s
					legal_body.gsub! '##familiar_reference_country', result.to_s
				end

				if !guardian.state_id.nil?
					result = guardian.state.label.to_s
					legal_body.gsub! '##familiar_reference_state', result.to_s
				end

				if !guardian.city_id.nil?
					result = guardian.city.label.to_s
					legal_body.gsub! '##familiar_reference_city', result.to_s
				end

			end
		end




		# Personal Reference Information

		result = nil
		personal_reference = target_user.reference.find_by(reference_case:["personal_reference"],row: 0)
		if !personal_reference.nil?
			personal_reference.attributes = translate_approval_input(personal_reference)

			result = personal_reference.name.to_s
			legal_body.gsub! '##personal_reference_name', result.to_s

			result = personal_reference.identification_number.to_s
			legal_body.gsub! '##personal_reference_document_number', result.to_s

			result = personal_reference.reference_email.to_s
			legal_body.gsub! '##personal_reference_mail', result.to_s
		
			result = I18n.t("list.#{personal_reference.indentification_case.to_s}")
			legal_body.gsub! '##type_personal_reference_document', result.to_s
		
			result = personal_reference.mobile.to_s
			legal_body.gsub! '##personal_reference_mobile1', result.to_s
		
			result = personal_reference.other_phone.to_s
			legal_body.gsub! '##personal_reference_mobile2', result.to_s

			result = personal_reference.phone.to_s
			legal_body.gsub! '##personal_reference_phone', result.to_s

			result = personal_reference.municipality.to_s
			legal_body.gsub! '##personal_reference_municipality', result.to_s

			result = personal_reference.neighborhood.to_s
			legal_body.gsub! '##personal_reference_neighborhood', result.to_s

			result = personal_reference.zip_code.to_s
			legal_body.gsub! '##personal_reference_zip_code', result.to_s

			result = personal_reference.address_1.to_s
			legal_body.gsub! '##personal_reference_address_1', result.to_s

			result = personal_reference.address_2.to_s
			legal_body.gsub! '##personal_reference_address_2', result.to_s

			result = personal_reference.rfc.to_s
			legal_body.gsub! '##personal_reference_rfc', result.to_s

			if !personal_reference.country_id.nil?
				result = personal_reference.country.label.to_s
				legal_body.gsub! '##personal_reference_country', result.to_s
			end

			if !personal_reference.state_id.nil?
				result = personal_reference.state.label.to_s
				legal_body.gsub! '##personal_reference_state', result.to_s
			end

			if !personal_reference.city_id.nil?
				result = personal_reference.city.label.to_s
				legal_body.gsub! '##personal_reference_city', result.to_s
			end
		end

		# Jointly Liable Information


		result = nil
		jointly_liable = target_user.reference.includes([:pending_changes, :city, :country, :state]).select{|r| r.reference_case == 'jointly_liable' }.first
		if !jointly_liable.nil?
			jointly_liable.attributes = translate_approval_input(jointly_liable)
			result = jointly_liable.name.to_s
			legal_body.gsub! '##jointly_liable_name', result.to_s

			result = jointly_liable.city.label.to_s if !jointly_liable.city.nil?
			legal_body.gsub! '##jointly_liable_city', result.to_s

			result = jointly_liable.identification_number.to_s
			legal_body.gsub! '##jointly_liable_document_number', result.to_s

			result = jointly_liable.reference_email.to_s
			legal_body.gsub! '##jointly_liable_mail', result.to_s
		
			result = I18n.t("list.#{jointly_liable.indentification_case.to_s}")
			legal_body.gsub! '##type_jointly_liable_document', result.to_s
		
			result = jointly_liable.mobile.to_s
			legal_body.gsub! '##jointly_liable_mobile1', result.to_s
		
			result = jointly_liable.other_phone.to_s
			legal_body.gsub! '##jointly_liable_mobile2', result.to_s

			result = jointly_liable.phone.to_s
			legal_body.gsub! '##jointly_liable_phone', result.to_s

			result = jointly_liable.municipality.to_s
			legal_body.gsub! '##jointly_liable_municipality', result.to_s

			result = jointly_liable.neighborhood.to_s
			legal_body.gsub! '##jointly_liable_neighborhood', result.to_s

			result = jointly_liable.zip_code.to_s
			legal_body.gsub! '##jointly_liable_zip_code', result.to_s

			result = jointly_liable.address_1.to_s
			legal_body.gsub! '##jointly_liable_address_1', result.to_s

			result = jointly_liable.address_2.to_s
			legal_body.gsub! '##jointly_liable_address_2', result.to_s

			result = jointly_liable.rfc.to_s
			legal_body.gsub! '##jointly_liable_rfc', result.to_s


			legal_body.gsub! '##jointly_liable_country', (jointly_liable.country&.label&.capitalize || '')

			legal_body.gsub! '##jointly_liable_marital_status', (I18n.t("reference.#{jointly_liable.marital_status}") || '')

			legal_body.gsub! '##jointly_liable_birthday', (jointly_liable.birthday.to_s || '')

			legal_body.gsub! '##jointly_liable_nationality', (jointly_liable.nationality.to_s || '')
			legal_body.gsub! '##jointly_liable_curp_id', (jointly_liable.curp_id.to_s || '')
			legal_body.gsub! '##jointly_liable_curp_document', (jointly_liable.curp_document.to_s || '')
			legal_body.gsub! '##jointly_liable_incomes', (jointly_liable.total_income.to_s || '')
			legal_body.gsub! '##to_letters_jointly_liable_incomes', (number_to_word(jointly_liable.total_income)  || '')
			legal_body.gsub! '##jointly_liable_labor_situation', (I18n.t("reference.#{jointly_liable.labor_situation}") || '')
			legal_body.gsub! '##jointly_liable_occupation', (jointly_liable.occupation || '')

			


			if !jointly_liable.state_id.nil?
				result = jointly_liable.state.label.to_s
				legal_body.gsub! '##jointly_liable_state', result.to_s
			end

			if !jointly_liable.city_id.nil?
				result = jointly_liable.city.label.to_s
				legal_body.gsub! '##jointly_liable_city', result.to_s
			end
		end


		## Funding Option Information

		if !target_application.nil? && target_application.funding_option.selected?
			legal_body.gsub! '##unemployment_month_period', target_application.funding_option.selected.first.unemployment_allowed.to_s

			if target_application.application_case == 'add_disbursement_modeling'
				financed_value = target_application.funding_option.selected.first.disbursement.where.not(disbursement_case: 'academic_bonus').pluck(:adjusted_student_value).reduce(:+).to_f
			else
				financed_value = target_application.funding_option.selected.first.total_pending_disbursement_logic.to_f
			end

			legal_body.gsub! '##financed_value', lumni_currency(financed_value)
			legal_body.gsub! '##the_financed_value_in_words', number_to_word(financed_value)
			legal_body.gsub! '##months_grace', target_application.funding_option.selected.first.grace_period_allowed.to_i.to_s
			legal_body.gsub! '##paid_culture', lumni_currency( target_application.funding_option.selected.first.nominal_payment_allowed.to_s)
			legal_body.gsub! '##percent_study', target_application.funding_option.selected.first.percentage_student.to_s
			legal_body.gsub! '##repayment_percentage', target_application.funding_option.selected.first.percentage_graduated.to_s
			isa_term_fo  = target_application.funding_option.selected.first.isa_term
			legal_body.gsub! '##number_of_agreed_fees', isa_term.to_s

			if target_user.active_isa.any?
				legal_body.gsub! '##number_repayments_pending', 	(isa_term.to_f - target_user.active_isa.first.repayment_payed_number.to_f).round(2).to_s
			end
			
			legal_body.gsub! '##disbursements', render("/legal_documents/partial/disbursement_table",application: target_application, disbursements:target_application.funding_option.selected.first.disbursement.where(disbursement_case: ['tuition','living_expenses']).where.not(status: 'canceled'))
			legal_body.gsub! '##table_disbursements_living_expenses', render("/legal_documents/partial/disbursement_table",application: target_application, disbursements:target_application.funding_option.selected.first.disbursement.where(disbursement_case: ['living_expenses']).where.not(status: 'canceled'))
			legal_body.gsub! '##table_disbursements_tuition', render("/legal_documents/partial/disbursement_table",application: target_application, disbursements:target_application.funding_option.selected.first.disbursement.where(disbursement_case: ['tuition']).where.not(status: 'canceled'))
		end





		if !target_application.nil? && !target_application.program_to_fund.nil?
			legal_body.gsub! '##financing_periods', target_application.program_to_fund.number_of_disbursements_requiered.to_s
		end


		if target_application.present? && target_user.new_agreement? && target_application.funding_option.selected.any?
			legal_body.gsub! '##financing_periods', (target_application.funding_option.selected.first.tuition_disbursements.count.to_s	|| '')
		end

		legal_body.gsub! '##fund', (target_application&.funding_opportunity&.fund&.name || '')
		legal_body.gsub! '##convocatory', (target_application&.funding_opportunity&.name || '')


		legal_body.gsub! '##jump_page', " <div class='alwaysbreak'> </div>"

		return legal_body
	end



	def applicant_legal_table_header
		applicant_legal_fields.map{|f| LegalMatch.human_attribute_name(f)}

	end


	def applicant_legal_table_rows legal_matches
		result = []
		legal_matches.each do |legal_match|
			temp_array = applicant_legal_fields.map{|field| applicant_legal_table_translation legal_match, field}
			result += [temp_array]
		end
		return result
	end

	def applicant_legal_fields
		["id","name","document_type", "validation_method","created_at", "status", 'scanned_document']
	end

	def applicant_legal_table_translation legal_match, field
		case field
		when 'created_at'
			result = lumni_date(legal_match.send(field))
		when 'status','validation_method','document_type'
			result = ((legal_match.send(field).nil? || legal_match.send(field) == '') ? nil : I18n.t('list.' + legal_match.send(field)) )
		when 'name'
			result = link_to(legal_match.send(field), legal_document_legal_match_path(legal_match), target: :blank, class: 'text-primary')
		when 'id'
			result = link_to(legal_match.send(field),edit_legal_match_path(legal_match),class: 'text-primary', remote: true,data: { disable_with: I18n.t('form.please_wait')})
		when 'scanned_document'
			result = legal_match.scanned_document.attached? ? link_to(I18n.t('list.document') ,legal_match.scanned_document) : I18n.t('list.no_records')
		else
			result = legal_match.send(field)
		end
		return result
	end
end

