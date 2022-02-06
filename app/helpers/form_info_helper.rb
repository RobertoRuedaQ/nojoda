module FormInfoHelper
	# options:
	# 	controller: The list of controller will be used as sublist in the side bar
	# 	icon: The icon in the sidebar menu
	# 	required: whether a field is required
	# 	list: the list elements. They must have labels and values
	# 	disabled: whether to set the field as disabled
	# 	field_type: to customize the field type against the natural field type
	# 	min: Minimum value the field can have
	# 	max: Maximum value the field can have
	#   error_message: to get a list of custom error messages if invalid.
	#   boolean_text: to set a text aside the switch
	#   placeholder: Sets a custom placeholder text
	#   grid: sets a custom number of col in the bootstrap grid definition

	def system_variables
		#Variables that should never and ever be editable in views 
		['id','external_id','discarded_at','migrated','created_at','updated_at','encrypted_password','reset_password_token',
		'reset_password_sent_at','remember_created_at','sign_in_count','current_sign_in_at','last_sign_in_at','current_sign_in_ip','last_sign_in_ip',
		'confirmation_token','confirmed_at','confirmation_sent_at','unconfirmed_email','failed_attempts','unlock_token','locked_at',
		'external_id','discarded_at','migrated','type','type_of_account']
	end




	def sidebar_fields
		fields = {}
		fields[:system_manager] = {controllers: ['teams','team_profiles','companies','countries','form_templates','form_lists','docs_generals','support_roles'], icon: 'ion ion-md-cog'}
		fields[:migrations] = {controllers: ['migrations','model_and_fields','check_objects','backup_objects'], icon: 'fas fa-exchange-alt'}
		fields[:feedbacks] = {controllers: ['feedbacks'], icon: 'ion ion-ios-bug'}
		fields[:financial_model] = {controllers: ['research_processes','modelings','research_variables','research_filters','research_inputs','research_model_infos'], icon: 'ion ion-ios-stats'}
		fields[:api] = {controllers: ['api_histories','payu_gateways'], icon: 'ion ion-md-git-network'}
		fields[:bizdev] = {controllers: ['bizdev_businesses','bizdev_operations'], icon: 'ion ion-md-battery-charging'}
		fields[:application_config] = {icon: 'ion ion-md-construct', controllers: ['interview_templates']}
		fields[:communication] = {controllers: ['communication_templates','communication_cases','communication_headers','communication_footers'],icon: 'ion ion-ios-mail'}
		fields[:notification] = {controllers: ['notifications','notification_cases'],icon: 'ion ion-md-notifications'}
		fields[:projects] = {controllers: ['projects','project_task_types'],icon: 'ion ion-md-barcode'}
		fields[:academic_config] = {controllers: ['institutions'], icon: 'ion ion-md-business'}
		fields[:questionnaires] = {controllers: ['questionnaires'], icon: 'ion ion-md-clipboard'}
		fields[:pricing] = {controllers: ['pricing_tables','pricing_details','pricing_vectors'], icon: 'ion ion-md-calculator'}
		fields[:students] = {controllers: ['applicants','students','collections'],icon: 'ion ion-ios-contacts'}
		fields[:funds] = {controllers: ['funds','funding_opportunities','legal_documents','originations'], icon: 'ion ion-ios-bonfire'}
		fields[:investment_committees] = {controllers: ['invest_committees'], icon: 'ion ion-md-briefcase'}
		fields[:disbursement_payments] = {controllers: ['disbursement_payments'], icon: 'ion ion-ios-cash'}
		fields[:applications] = {controllers: ['applications'],icon: 'ion ion-ios-bulb'}
		fields[:disclosures_and_contracts] = {icon: 'ion ion-ios-paper'}
		fields[:disbursements] = {icon: 'ion ion-ios-apps'}
		fields[:payments] = {controllers: ['payment_batches','payu_responses','payment_masses'],icon: 'ion ion-md-speedometer'}
		fields[:reports] = {controllers: ['dashboards'],icon: 'ion ion-ios-speedometer'}
		fields[:contact] = {icon: 'ion ion-md-contacts'}


		return fields

	end


	def value_to_be_payed_fields
		fields = {}
		fields[:value] = {required: true,grid: 12,field_type: 'string'}
		return fields
	end

	def payment_info_cash_fields_for_wompi(billing_document, acceptance_token)
		gateway = billing_document.isa.funding_opportunity.fund.wompi_gateway
		acceptance_token_text = "Acepto haber leído los <a href='#{acceptance_token['permalink']}' target='_blank'>los términos y condiciones y la politica de privacidad</a> para hacer esta compra."
		fields = {}
		fields[:ip_address] = {required: true,grid: 6,field_type: 'string',hidden: true,value: request.remote_ip,custom_label: I18n.t('activerecord.attributes.payment_info.ip_address'),grid: 12}
		fields[:user_agent] = {required: true,grid: 6,field_type: 'string',hidden: true,value: request.user_agent,custom_label: I18n.t('activerecord.attributes.payment_info.user_agent'),grid: 12}
		fields[:billing_document_id] = {required: true, grid: 6,field_type: 'string',hidden: true, value: billing_document.id,custom_label: I18n.t('activerecord.attributes.payment_info.billing_document_id'),grid: 12}
		fields[:value] = {required: true,grid: 6,field_type: 'currency', hidden: true,custom_label: I18n.t('activerecord.attributes.payment_info.value'),grid: 12}
		fields[:payment_method] = {required: true,grid: 6,field_type: 'string',value: 'BANCOLOMBIA_COLLECT',custom_label: I18n.t('activerecord.attributes.payment_info.payment_method'),grid: 12,hidden: true}
		fields[:accepts_terms_and_conditions] = {required: false, hidden: true, grid: 6,field_type: 'boolean', boolean_text: acceptance_token_text,grid: 12}
		fields[:security_code] = {required: true,grid: 6,field_type: 'string',hidden: true,value: acceptance_token['acceptance_token'] ,custom_label: 'Token de aceptacion',grid: 12}

		return fields
	end

	def payment_info_pse_fields_for_wompi(billing_document, acceptance_token)
		gateway = billing_document.isa.funding_opportunity.fund.wompi_gateway
		acceptance_token_text = "Acepto haber leído los <a href='#{acceptance_token['permalink']}' target='_blank'>los términos y condiciones y la politica de privacidad</a> para hacer esta compra."
		fields = {}
		fields[:financial_institution] = {required: true,grid: 6,field_type: 'string',custom_label: I18n.t('activerecord.attributes.payment_info.financial_institution'),grid: 12,list: bank_list_pse(gateway)}
		fields[:user_type] = {required: true,grid: 6,field_type: 'string',custom_label: I18n.t('activerecord.attributes.payment_info.user_type'),grid: 12,list: user_type_pse_for_wompi}
		fields[:payer_full_name] = {required: true,grid: 6,field_type: 'string',value: billing_document.user_name,custom_label: I18n.t('activerecord.attributes.payment_info.payer_full_name'),grid: 12}
		fields[:payer_dni_type] = {required: true, grid: 6,field_type: 'string',custom_label: I18n.t('activerecord.attributes.payment_info.payer_dni_type'),list: document_type_wompi,grid: 12}
		fields[:payer_dni_number] = {required: true,grid: 6,field_type: 'string',custom_label: I18n.t('activerecord.attributes.payment_info.payer_dni_number'),grid: 12}
		fields[:payer_email] = {required: true,grid: 6,field_type: 'email',value: billing_document.email,custom_label: I18n.t('activerecord.attributes.payment_info.payer_email'),grid: 12}
		fields[:payer_phone] = {required: true,grid: 6,field_type: 'string',value: billing_document.mobile,custom_label: I18n.t('activerecord.attributes.payment_info.payer_phone'),grid: 12}
		fields[:payment_method] = {required: true,grid: 6,field_type: 'string',value: 'PSE',custom_label: I18n.t('activerecord.attributes.payment_info.payment_method'),grid: 12,hidden: true}
		fields[:device_session_id] = {required: true, value: session['session_id'],field_type: 'string',hidden: true,custom_label: I18n.t('activerecord.attributes.payment_info.device_session_id'),grid: 12}
		fields[:order_id] = { grid: 6,field_type: 'string',hidden: true,custom_label: I18n.t('activerecord.attributes.payment_info.order_id'),grid: 12}
		fields[:device_session_id_with_user_id] = { grid: 6,field_type: 'string',hidden: true,custom_label: I18n.t('activerecord.attributes.payment_info.device_session_id_with_user_id'),grid: 12}
		fields[:billing_document_id] = {required: true, grid: 6,field_type: 'string',hidden: true, value: billing_document.id,custom_label: I18n.t('activerecord.attributes.payment_info.billing_document_id'),grid: 12}
		fields[:value] = {required: true,grid: 6,field_type: 'currency', hidden: true,custom_label: I18n.t('activerecord.attributes.payment_info.value'),grid: 12}
		fields[:base] = {required: true,grid: 6,field_type: 'currency',hidden: true,value: 0,custom_label: I18n.t('activerecord.attributes.payment_info.base'),grid: 12}
		fields[:tax] = {required: true,grid: 6,field_type: 'currency',hidden: true,value:0,custom_label: I18n.t('activerecord.attributes.payment_info.tax'),grid: 12}
		fields[:ip_address] = {required: true,grid: 6,field_type: 'string',hidden: true,value: request.remote_ip,custom_label: I18n.t('activerecord.attributes.payment_info.ip_address'),grid: 12}
		fields[:user_agent] = {required: true,grid: 6,field_type: 'string',hidden: true,value: request.user_agent,custom_label: I18n.t('activerecord.attributes.payment_info.user_agent'),grid: 12}
		fields[:accepts_terms_and_conditions] = {required: true,grid: 6,field_type: 'boolean', boolean_text: acceptance_token_text,grid: 12}
		fields[:security_code] = {required: true,grid: 6,field_type: 'string',hidden: true,value: acceptance_token['acceptance_token'] ,custom_label: 'Token de aceptacion',grid: 12}

		return fields
	end


	def payment_info_pse_fields billing_document
		fields = {}
		fields[:financial_institution] = {required: true,grid: 6,field_type: 'string',custom_label: I18n.t('activerecord.attributes.payment_info.financial_institution'),grid: 12,list: bank_list_pse( billing_document.gateway)}
		fields[:user_type] = {required: true,grid: 6,field_type: 'string',custom_label: I18n.t('activerecord.attributes.payment_info.user_type'),grid: 12,list: user_type_pse}
		fields[:payer_full_name] = {required: true,grid: 6,field_type: 'string',value: billing_document.user_name,custom_label: I18n.t('activerecord.attributes.payment_info.payer_full_name'),grid: 12}
		fields[:payer_dni_type] = {required: true, grid: 6,field_type: 'string',custom_label: I18n.t('activerecord.attributes.payment_info.payer_dni_type'),list: document_type_payu,grid: 12}
		fields[:payer_dni_number] = {required: true,grid: 6,field_type: 'string',custom_label: I18n.t('activerecord.attributes.payment_info.payer_dni_number'),grid: 12}
		fields[:payer_email] = {required: true,grid: 6,field_type: 'email',value: billing_document.email,custom_label: I18n.t('activerecord.attributes.payment_info.payer_email'),grid: 12}
		fields[:payer_phone] = {required: true,grid: 6,field_type: 'string',value: billing_document.mobile,custom_label: I18n.t('activerecord.attributes.payment_info.payer_phone'),grid: 12}
		fields[:payment_method] = {required: true,grid: 6,field_type: 'string',value: 'PSE',custom_label: I18n.t('activerecord.attributes.payment_info.payment_method'),grid: 12,hidden: true}
		fields[:device_session_id] = {required: true, value: session['session_id'],field_type: 'string',hidden: true,custom_label: I18n.t('activerecord.attributes.payment_info.device_session_id'),grid: 12}
		fields[:order_id] = { grid: 6,field_type: 'string',hidden: true,custom_label: I18n.t('activerecord.attributes.payment_info.order_id'),grid: 12}
		fields[:device_session_id_with_user_id] = { grid: 6,field_type: 'string',hidden: true,custom_label: I18n.t('activerecord.attributes.payment_info.device_session_id_with_user_id'),grid: 12}
		fields[:billing_document_id] = {required: true, grid: 6,field_type: 'string',hidden: true, value: billing_document.id,custom_label: I18n.t('activerecord.attributes.payment_info.billing_document_id'),grid: 12}
		fields[:value] = {required: true,grid: 6,field_type: 'currency', hidden: true,custom_label: I18n.t('activerecord.attributes.payment_info.value'),grid: 12}
		fields[:base] = {required: true,grid: 6,field_type: 'currency',hidden: true,value: 0,custom_label: I18n.t('activerecord.attributes.payment_info.base'),grid: 12}
		fields[:tax] = {required: true,grid: 6,field_type: 'currency',hidden: true,value:0,custom_label: I18n.t('activerecord.attributes.payment_info.tax'),grid: 12}
		fields[:ip_address] = {required: true,grid: 6,field_type: 'string',hidden: true,value: request.remote_ip,custom_label: I18n.t('activerecord.attributes.payment_info.ip_address'),grid: 12}
		fields[:user_agent] = {required: true,grid: 6,field_type: 'string',hidden: true,value: request.user_agent,custom_label: I18n.t('activerecord.attributes.payment_info.user_agent'),grid: 12}
		
		return fields
	end



	def payment_info_debit_fields billing_document
		fields = {}
		fields[:payer_full_name] = {required: true,grid: 12,field_type: 'string',value: billing_document.user_name,custom_label: I18n.t('activerecord.attributes.payment_info.payer_full_name')}
		if billing_document.currency == 'MXN'
			fields[:birthday] = {required: true,grid: 12,field_type: 'date',custom_label: I18n.t('activerecord.attributes.payment_info.birthday'),value: billing_document.birthday}
		end

		fields[:payer_email] = {required: true,grid: 12,field_type: 'email',value: billing_document.email,custom_label: I18n.t('activerecord.attributes.payment_info.payer_email')}
		fields[:payer_phone] = {required: true,grid: 12,field_type: 'string',value: billing_document.mobile,custom_label: I18n.t('activerecord.attributes.payment_info.payer_phone')}
		fields[:payer_address1] = {required: true, grid: 12,field_type: 'string',custom_label: I18n.t('activerecord.attributes.payment_info.payer_address1')}
		fields[:payer_country] = {required: true, grid: 12,field_type: 'string',custom_label: I18n.t('activerecord.attributes.payment_info.payer_country'),list: pais_payu,value: billing_document.user.company.country.international_code}
		fields[:payer_state] = {required: true, grid: 12,field_type: 'string',custom_label: I18n.t('activerecord.attributes.payment_info.payer_state')}
		fields[:payer_city] = {required: true, grid: 12,field_type: 'string',custom_label: I18n.t('activerecord.attributes.payment_info.payer_city')}
 		fields[:payer_postal_code] = {required: true, grid: 12,field_type: 'string',custom_label: I18n.t('activerecord.attributes.payment_info.payer_postal_code')}
		fields[:payer_dni_number] = {required: true,grid: 12,field_type: 'string',custom_label: I18n.t('activerecord.attributes.payment_info.payer_dni_number')}
		fields[:payment_method] = {required: true,grid: 12,field_type: 'string',custom_label: I18n.t('activerecord.attributes.payment_info.payment_method'),list: debit_card_payu}
		fields[:card_name] = {required: true,grid: 12,field_type: 'string',custom_label: I18n.t('activerecord.attributes.payment_info.card_name')}
		fields[:card_number] = {required: true,grid: 12,field_type: 'string',custom_label: I18n.t('activerecord.attributes.payment_info.card_number')}
		fields[:security_code] = {required: true,grid: 12,field_type: 'string',custom_label: I18n.t('activerecord.attributes.payment_info.security_code')}
		fields[:expiration_month] = {required: true,grid: 12,field_type: 'string',custom_label: I18n.t('activerecord.attributes.payment_info.expiration_month'), list: payment_card_month_list}
		fields[:expiration_year] = {required: true,grid: 12,field_type: 'string',custom_label: I18n.t('activerecord.attributes.payment_info.expiration_year'),list: expired_year}
		fields[:installments_number] = {required: true,grid: 12,field_type: 'string',custom_label: I18n.t('activerecord.attributes.payment_info.installments_number'),value: 1, hidden: true}
		fields[:device_session_id] = {required: true, value: session['session_id'],field_type: 'string',hidden: true,custom_label: I18n.t('activerecord.attributes.payment_info.device_session_id')}
		fields[:order_id] = { grid: 12,field_type: 'string',hidden: true,custom_label: I18n.t('activerecord.attributes.payment_info.order_id')}
		fields[:recurring_payment] = { grid: 12,field_type: 'string',hidden: true,custom_label: I18n.t('activerecord.attributes.payment_info.recurring_payment')}
		fields[:accepts_terms_and_conditions] = { grid: 12,field_type: 'string',hidden: true,custom_label: I18n.t('activerecord.attributes.payment_info.accepts_terms_and_conditions')}
		fields[:device_session_id_with_user_id] = { grid: 12,field_type: 'string',hidden: true,custom_label: I18n.t('activerecord.attributes.payment_info.device_session_id_with_user_id')}
		fields[:billing_document_id] = {required: true, grid: 12,field_type: 'string',hidden: true, value: billing_document.id,custom_label: I18n.t('activerecord.attributes.payment_info.billing_document_id')}
		fields[:value] = {required: true,grid: 12,field_type: 'currency', hidden: true,custom_label: I18n.t('activerecord.attributes.payment_info.value')}
		fields[:base] = {required: true,grid: 12,field_type: 'currency',hidden: true,value: 0,custom_label: I18n.t('activerecord.attributes.payment_info.base')}
		fields[:tax] = {required: true,grid: 12,field_type: 'currency',hidden: true,value:0,custom_label: I18n.t('activerecord.attributes.payment_info.tax')}
		fields[:ip_address] = {required: true,grid: 12,field_type: 'string',hidden: true,value: request.remote_ip,custom_label: I18n.t('activerecord.attributes.payment_info.ip_address')}
		fields[:user_agent] = {required: true,grid: 12,field_type: 'string',hidden: true,value: request.user_agent,custom_label: I18n.t('activerecord.attributes.payment_info.user_agent')}

		return fields
	end

	def payment_info_fields_test billing_document, payment_method
		fields = {}
		fields[:payer_full_name] = {required: true,grid: 6,field_type: 'string',value: billing_document.user_name}
		if billing_document.currency == 'MXN'
			fields[:birthday] = {required: true,grid: 6,field_type: 'date',custom_label: I18n.t('activerecord.attributes.payment_info.birthday')}
		end
		fields[:payer_email] = {required: true,grid: 6,field_type: 'email',value: billing_document.email}
		fields[:payer_dni_type] = {required: true, grid: 6,field_type: 'string',value: 'CC'}
		fields[:payer_dni_number] = {required: true,grid: 6,field_type: 'string',value: '5415668464654'}
		fields[:payer_phone] = {required: true,grid: 6,field_type: 'string',value: billing_document.mobile}
		fields[:payment_method] = {required: true,grid: 6,field_type: 'string',value: payment_method}
		fields[:card_name] = {required: true,grid: 6,field_type: 'string',value: 'REJECTED' }
		fields[:card_number] = {required: true,grid: 6,field_type: 'string',value: '4097440000000004'}
		fields[:security_code] = {required: true,grid: 6,field_type: 'string',value: '321'}
		fields[:expiration_month] = {required: true,grid: 6,field_type: 'string',value: '12',list: months_number_list}
		fields[:expiration_year] = {required: true,grid: 6,field_type: 'string',value: '2020'}
		fields[:installments_number] = {required: true,grid: 6,field_type: 'string',value: '1'}
		fields[:payer_phone] = {required: true, grid: 6,field_type: 'string',value: '7563126'}
		fields[:payer_address1] = {required: true, grid: 6,field_type: 'string',value: 'calle 93'}
		fields[:payer_address2] = {required: true, grid: 6,field_type: 'string',value: '125544'}
		fields[:payer_city] = {required: true, grid: 6,field_type: 'string', value: 'Bogota'}
		fields[:payer_state] = {required: true, grid: 6,field_type: 'string', value: 'Bogota DC'}
		fields[:payer_country] = {required: true, grid: 6,field_type: 'string', value: 'CO'}
 		fields[:payer_postal_code] = {required: true, grid: 6,field_type: 'string',value: '000000'}
		fields[:device_session_id] = {required: true, value: session['session_id'],field_type: 'string',hidden: true}
		fields[:order_id] = { grid: 6,field_type: 'string',hidden: true}
		fields[:recurring_payment] = { grid: 6,field_type: 'string',hidden: true}
		fields[:accepts_terms_and_conditions] = { grid: 6,field_type: 'string',hidden: true}
		fields[:device_session_id_with_user_id] = { grid: 6,field_type: 'string',hidden: true}
		fields[:billing_document_id] = {required: true, grid: 6,field_type: 'string',hidden: true, value: billing_document.id}
		fields[:value] = {required: true,grid: 6,field_type: 'currency', hidden: true}
		fields[:base] = {required: true,grid: 6,field_type: 'currency',hidden: true,value: 0}
		fields[:tax] = {required: true,grid: 6,field_type: 'currency',hidden: true,value:0}
		fields[:ip_address] = {required: true,grid: 6,field_type: 'string',hidden: true,value: request.remote_ip}
		fields[:user_agent] = {required: true,grid: 6,field_type: 'string',hidden: true,value: request.user_agent}

		return fields
	end


	def academic_dates_fields
		fields = {}
		fields[:expected_egress_date] = {grid: 12}
		fields[:egress_date] = {grid: 12}
		fields[:expected_graduation_date] = {grid: 12}
		fields[:graduation_date] = {grid: 12}
		fields[:expected_diploma_delivery_date] = {grid: 12}
		fields[:diploma_delivery_date] = {grid: 12}
		fields[:drop_out_date] = {grid: 12}
		return fields
	end


	def profile_fields
		fields = {}
		fields[:first_name] = {required: true}
		fields[:last_name] = {required: true}
		fields[:language] = {required: true,list: languageList}
		fields[:time_zone] = {required: true,list: timezoneList}
		fields[:email] = {required: true}

		return fields
	end

	def users_fields
		teams_fields
	end

	def students_fields
		fields = {}
		fields[:first_name] = {required: true}
		fields[:last_name] = {required: true}
		fields[:language] = {list: languageList, required: true}
		fields[:time_zone] = {list: timezoneList}
		fields[:email] = {required: true,field_type: 'email'}
		fields[:status] = {list: teamStatusList, required: true}
		fields[:sign_in_count] = {}
		return fields
	end

	def teams_fields
		fields = {}
		fields[:first_name] = {required: true}
		fields[:last_name] = {required: true}
		fields[:language] = {list: languageList, required: true}
		fields[:time_zone] = {list: timezoneList}
		fields[:email] = {required: true,field_type: 'email'}
		fields[:team_profile_id] = {required: true, list: teamProfileList}
		fields[:status] = {list: teamStatusList, required: true}
		fields[:sign_in_count] = {}
		return fields
	end

	def contact_infos_fields
		fields = {}
		fields[:mobile] = {}
		fields[:phone] = {}
		fields[:other_phone] = {}
		fields[:email] = {}
		fields[:secondary_email] = {}
		return fields
	end


	def fund_fields
		fields = {}
		fields[:name] = {required: true}
		fields[:fund_id] = {list: fundList}
		fields[:preapproval_by_investor] = {}
		fields[:renewal_in_years] = {required: true}
		fields[:active] = {}
		fields[:applies_taxes] = {}
		fields[:close_day] = {required: true}
		fields[:timely_payment_day] = {required: true}
		fields[:start_date] = {required: true}
		fields[:close_date] = {required: true}
		fields[:extension_periods] = {required: true}

		return fields
	end

	def roles_fields
		fields = {}
		fields[:name] = {required: true}

		return fields
	end

	def legal_documents_fields
		fields = {}
		fields[:name] = {required: true}
		fields[:document_type] = {list: legalDocumentTypeList, required: true}
		fields[:status] = {list: legalStatusList,required: true}
		fields[:language] = {required: true,list: languageList}
		fields[:access] = {required: true,list: legalAccessList}
		fields[:validation_method] = {required: true,list: legalValidationList}
		fields[:activation_method] = {required: true,list: legalActivationList}
		fields[:legal_documents_id] = {list: legalParentList}
		fields[:company_id] = {required: true,list: companiesList}
		fields[:validation] = {required: true,field_type: 'text', grid: 12}
		fields[:body] = {required: true,field_type: 'full_editor',grid: 12}

		return fields
	end



	def companies_fields current_company
		fields = {}
		fields[:name] = {}
		fields[:user_id] = {list: signerList}
		fields[:company_id] = {list: companiesList}
		fields[:country_id] ={list: countryList}
		fields[:status] = {list: generalStatusList}
		fields[:url] = {}
		fields[:default_language] = {list: languageList}
		fields[:main_title] = {}
		fields[:slogan] = {}
		fields[:timezone] = {list: timezoneList}
		fields[:credit_check_disclosure_id] = {list: credit_check_list}
		fields[:automatic_proposal_display] = {field_type: 'boolean'}
		fields[:income_origination_id] = {list: origination_full_list}
		fields[:main_logo] = {field_type: 'file'}
		fields[:login_logo] = {field_type: 'file'}
		fields[:signup_logo] = {field_type: 'file'}
		fields[:custom_origination_end] = {field_type: 'boolean'}
		fields[:default_months] = {field_type: 'integer'}
		fields[:min_unid_collection] = {field_type: 'interger'}
		fields[:min_self_representation_age] = {field_type: 'integer'}
		fields[:origination_funded_major_id] = {field_type: 'integer'}

		fields[:final_origination_text] = {field_type: 'full_editor',grid: 12}

		return fields
	end

	def country_fields
		fields = {}
		fields[:name] = {}
		fields[:yearly_usury_rate] = {}
		fields[:round_up_to] = {}
		fields[:currency] = {list: currencyList}
		fields[:international_code] = {}
		return fields
	end

	def funding_opportunity_fields current_company
		fields = {}
		fields[:name] = {required: true}
		fields[:fund_id] = {list: fundList, required: true}
		fields[:field_work_required] = {}
		fields[:available_places] = {required: true}
		fields[:status] = {list: generalStatusList,required: true}
		fields[:start_date] = {required: true}
		fields[:close_date] = {required: true}
		fields[:budget] = {field_type: 'currency',required: true}
		fields[:opportunity_type] = {list: funding_opportunity_types,required: true}
		fields[:origination_id] = {list: origination_full_list, required: true}
		fields[:signer_id] = {list: teamMembersList(current_company), required: true}
		fields[:eligibility_criteria_id] = {list: elitibility_criteria_list, required: true}
		fields[:contract_adult_id] = {list: contract_list, required: true}
		fields[:contract_young_id] = {list: contract_list, required: true}
		fields[:modeling_id] = {list: modeling_list, required: true}

		return fields
	end

	def migration_fields
		fields = {}
		fields[:id] = {}
		fields[:name] = {}
		fields[:type_of_migration] ={}
		fields[:status] = {}
		fields[:migration_id] = {}
		fields[:rails_object] = {}
		fields[:sf_object] = {}
		return fields
	end
	
	def institutions_fields
		fields = {}
		fields[:name] = {}
		fields[:status] = {}
		fields[:code] = {}
		fields[:website] = {}
		return fields
	end

	def pricing_tables_fields
		fields = {}
		fields[:institutions_id] = {}
		fields[:funding_opportunities_id] = {}
		fields[:grade_level] = {}
		fields[:cluster] = {}
		fields[:real_cap] = {}
		fields[:isa_length] = {}
		fields[:reference_value] = {}
		fields[:periodicity] = {}
		return fields
	end

	def pricing_details_fields
		fields = {}
		fields[:case] = {}
		fields[:min] = {}
		fields[:max] = {}
		fields[:percentage] = {}
		fields[:initial_income_cap] = {}
		fields[:cash_reserves_needed] = {}
		fields[:exit_year] = {}
		fields[:pricing_table_id] = {}
		return fields
	end

	def pricing_vectors_fields
		fields = {}
		fields[:pricing_detail_id] = {}
		fields[:salary] = {}
		fields[:repayment] = {}
		fields[:service] = {}
		return fields
	end

	def questionnaires_fields_parent current_company_id
		fields = {}
		fields[:name] = {}
		fields[:max_score] = {}
		fields[:min_approval_score] = {}
		fields[:time_limit] = {}
		fields[:instructions] = {field_type: 'full_editor',grid: 12}
		fields[:position] = {value: 0, hidden: true}
		fields[:company_id] = {value: current_company_id, hidden: true}
		return fields
	end

	def questionnaires_fields current_company_id
		fields = {}
		fields[:name] = {}
		fields[:parent_id] = {}
		fields[:validation] = {}
		fields[:max_score] = {}
		fields[:position] = {}
		fields[:min_approval_score] = {}
		fields[:time_limit] = {}
		fields[:weight] = {hidden:true}
		fields[:instructions] = {field_type: 'full_editor',grid: 12}
		fields[:company_id] = {value: current_company_id, hidden: true}
		return fields
	end

	def questionnaires_fields_section current_company_id
		fields = {}
		fields[:name] = {}
		fields[:max_score] = {}
		fields[:min_approval_score] = {}
		fields[:time_limit] = {}
		fields[:weight] = {}
		fields[:parent_id] = {hidden: true}
		fields[:position] = {hidden: true}
		fields[:company_id] = {value: current_company_id, hidden: true}
		return fields
	end



	def questions_fields
		fields = {}
		fields[:question] = {field_type: 'text',grid: 12}
		fields[:category] = {}
		fields[:max_score] = {}
		fields[:questionnaire_id] = {hidden: true}
		fields[:position] = {hidden: true}
		return fields
	end

	def answers_fields
		fields = {}
		fields[:answer] = {}
		fields[:score] = {}
		fields[:question_id] = {hidden: true}
		fields[:position] = {hidden: true}
		return fields
	end

	def projects_fields
		list = {}
		list[:title] = {grid: 12}
		list[:private] = {hidden: true}
		list[:owner_id] = {hidden: true}
		return list
	end

	def project_tasks_fields current_company
		list = {}
		list[:title] = {}
		list[:description] = {}
		list[:start_date] = {}
		list[:deadline] = {}
		list[:responsable_id] = {list: teamMembersList(current_company),required: true}
		list[:progress] = {field_type: 'percentage', max: 100, min: 0, step: 1}
		list[:private] = {}
		list[:done] = {hidden: true}
		list[:created_by_id] = {hidden: true}
		list[:project_task_type_id] = {hidden: true}
		list[:archived] = {hidden: true}
		list[:project_card_id] = {hidden: true}
		list[:position] = {hidden: true}
		list[:parent_id] = {hidden: true}

		return list
	end


	def project_tasks_fields_remote current_company
		list = {}
		list[:title] = {required:true}
		list[:description] = {}
		list[:start_date] = {}
		list[:deadline] = {}
		list[:responsable_id] = {list: teamMembersList(current_company),required: true}
		list[:progress] = {field_type: 'percentage', max: 100, min: 0, step: 1}
		list[:private] = {}
		list[:done] = {}
		list[:created_by_id] = {hidden: true}
		list[:project_task_type_id] = {hidden: true}
		list[:project_card_id] = {hidden: true}
		list[:position] = {hidden: true}
		list[:parent_id] = {hidden: true}


		return list
	end

	def project_task_types_fields
		list = {}
		list[:title] = {}
		list[:functionality] = {}
		list[:description] = {}
		return list
	end

	def project_comments_fields
		list = {}
		list[:comment] = {}
		list[:project_task_id] = {}
		list[:user_id] = {}
		return list
	end

	def project_comment_fields_remote
		list = {}
		list[:comment] = {required: true,grid: 12}
		list[:project_task_id] = {hidden: true}
		list[:user_id] = { hidden:true}
		return list
	end

	def communication_templates_fields company_id = nil
		list = {}
		list[:title] = {required: true}
		list[:subject] = {required: true}
		list[:communication_case_id] = {required: true, list: communicationCaseList(company_id),grid: 4}
		list[:communication_header_id] = {required: true, list: headersList(company_id),grid: 4}
		list[:company_id] = {required: true, list: companiesList,grid: 4}
		list[:communication_footer_id] = {required: true, list: footersList(company_id),grid: 4}
		list[:language] = {required: true, list: languageList, grid: 4}
		list[:status] = {required: true, list: generalStatusList, grid: 4}
		list[:body] = {required: true,field_type: 'full_editor',grid: 12}
		return list
	end
	def communication_cases_fields company_id = nil
		list = {}
		list[:title] = {required: true}
		list[:description] = {required: true}
		list[:company_id] = {hidden: true}
		return list
	end
	def communication_headers_fields company_id = nil
		list = {}
		list[:title] = {required: true, grid: 12}
		list[:body] = {required: true, field_type: 'full_editor',grid: 12}
		list[:company_id] = {hidden: true}
		return list
	end

	def communication_footers_fields company_id = nil
		list = {}
		list[:title] = {required: true, grid: 12}
		list[:body] = {required: true, field_type: 'full_editor', grid: 12}
		list[:company_id] = {hidden: true}
		return list
	end


	def project_teams_fields
		list = {}
		list[:user_id] = {required: true}
		list[:project_id] = {required: true, hidden: true}
		return list
	end

	def team_profiles_fields
		list = {}
		list[:name] = {required: true}
		list[:description] = {}
		return list
	end

	def form_templates_fields
		list = {}
		list[:name] = {required: true}
		list[:object] = {required: true}
		list[:parent_id] = {}
		return list
	end

	def form_fields_fields
		list = {}
		list[:name] = {required: true, disabled: true}
		list[:format] = {required: true, list: template_format_list}
		list[:grid] = {required: true, list: grid_list}

		return list
	end

	def form_attributes_fields
		list = {}
		list[:name] = {required: true, list: template_attribute_list}
		list[:value] = {required: true, field_type: 'string'}
		list[:form_field_id] = {hidden: true}

		return list
	end


 	def form_lists_fields
		list = {}
		list[:case] = {required: true}
		return list
 	end
 	def form_labels_fields
		list = {}
		list[:label] = {required: true}
		list[:language] = {required: true,hidden: true}
		list[:resource_id] = {required: true, hidden: true}
		list[:resource_type] = {required: true,hidden: true}
		return list
 	end

 	def form_list_values_fields
		list = {}
		list[:form_list_id] = {hidden: true}
		list[:value] = {required: true}
		return list
 	end

 	def origination_form_option option
 		list = {}
 		list[:resource_id] = {required: true, list: eval('origination_section_' + option)}
 		list[:order] = {hidden: true}
 		list[:resource_type] = {hidden: true}
 		list[:origination_module_id] = {hidden: true}
 		list[:options] = {}
 		list[:alternative_label] = {}
 		return list
 	end

 	def edit_origination_module_fields
 		list = {}
 		list[:name] = {required: true}
 		return list
 	end

 	def student_route_fields
 		list = {}
 		list[:scenario] = {list: student_route_list, required: true}
 		list[:team_profile_id] = {required: true, list: teamProfileList}
 		list[:company_id] = {hidden: true}
 		return list
 	end

 	def locations_fields
 		list = {}
 		list[:address1] = {}
 		list[:address2] = {}
 		list[:country_id] = {field_type: 'countries'}
 		list[:state_id] = {field_type: 'regions'}
 		list[:city_id] = { field_type: 'cities'}
 		return list

 	end

 	def personal_informations_fields
 		list = {}
 		list[:birthday] = {}
 		list[:marital_status] = {}
 		list[:gender] = {}
 		list[:document_type] = {}
 		list[:identification_number] = {}
 		return list
 	end
 	def legal_matches_fields
 		list = {}
 		list[:user_id] = {}
 		list[:legal_document_id] = {}
 		list[:validation_method] = {}
 		list[:validation] = {}
 		list[:resource_id] = {}
 		list[:resource_type] = {}
 		list[:answer] = {}
 		list[:body] = {}

 		return list
 	end

 	def migration_field_fields object
 		list = {}
 		list[:type_of_field] = {list: migration_field_type_options}
 		list[:sf_field] = {list: cached_sf_field_list( object)}
 		list[:object_reference] = {list: list_of_models}
 		list[:function_text] = {list: migration_field_migration_methods}
 		list[:fixed_value] = {}
 		list[:model_field] = {hidden: true}
 		return list
 	end
end
