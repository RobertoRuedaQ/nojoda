module ListsHelper 
	include LumniLanguage

	def legacy_status_3
		values = ['academic_status','general_status','payment_status','work_status']
		labels = ['Estado Académico','Estado General','Estado De Pagos', 'Estado Laboral']
		list = {}
		list[:options] = {values: values,labels: labels}
		return list
	end

	def legacy_status_4
		values = ['stored_academic_information','stored_general_status','stored_payment_status','stored_income_status']
		labels = ['Estado Académico','Estado General','Estado De Pagos', 'Estado Ingresos']
		list = {}
		list[:options] = {values: values,labels: labels}
		return list
	end


	def list_of_translated_items values, translation_group
		labels = values.map{|v| I18n.t("#{translation_group}.#{v}")}
		list = {}
		list[:options] = {values: values,labels: labels}
		return list
	end

	def list_form_collection target_collection, label_field
		if target_collection.nil?
			values = []
			labels = []
		else
			values = target_collection.ids
			labels = target_collection.pluck(label_field)
		end

		list = {}
		list[:options] = {values: values,labels: labels}
		return list
	end

	def disbursement_payment_type_list(disbursement)
		list = {}
		if disbursement.disbursement_case == "tuition"
			values = ['college_tuition_payment','reimbursement_of_money']
		else
			values = ['living_expenses_payment', 'emergency_living_expenses_payment']
		end
		labels = values.map{|v| I18n.t("application.#{v}")}
		list[:options] = {values: values,labels: labels}
		return list
	end

	def disbursement_university_grade_list(student)
		list = {}
		disbursements = student.active_isa.first.funding_option.disbursement
		disbursements = disbursements.reject{|d| d.status == 'payed' || d.status == 'partially_payed'} #discard disbursement that has been already payed
		disbursements = disbursements.reject{|d| d.disbursement_case == 'academic_bonus' || d.disbursement_case == 'emergency_living_expenses'} #don't include acaddemic bonuses nor emergency living expenses
		values = disbursements.pluck(:id)
		labels = disbursements.map{|d| "ID " + d.id.to_s + "/" + (I18n.t("disbursement.#{d.disbursement_case}") + "/" + d.forcasted_date.to_s )}
		## add option for final report
		values << nil
		labels << I18n.t("disbursement.last_disbursement")
		list[:options] = {values: values,labels: labels}
	end

	def institution_bank_account_list current_user
		funded_program = current_user.funded_academic_information
		if funded_program.present?
			institution_banks = funded_program.institution.bank_account
		end

		labels = []
		values = []

		if funded_program.present? && institution_banks.any?
			values += institution_banks.ids
			labels += institution_banks.map(&:account_label)
		end

		list = {}
		list[:options] = {values: values,labels: labels}
		return list
	end


	def user_bank_account_list current_user
		user_bank = current_user.bank_account

		labels = []
		values = []

		if user_bank.present?
			user_bank_account = user_bank.select{|ba| ba.active == true}.last
			values += [user_bank_account.id]
			labels += [user_bank_account.account_label]
		end

		list = {}
		list[:options] = {values: values,labels: labels}
		return list
	end


	def list_payu_gateways
		payu = PayuGateway.kept.pluck(:id, :name)
		mercado_pago = MercadoPagoGateway.kept.pluck(:id, :name)
		merged = payu | mercado_pago

		labels = []
		values = []

		merged.each do |gateway|
			values << gateway.first
			labels << gateway.second
		end
	
		list = {}
		list[:options] = {values: values,labels: labels}
		return list
	end

	def support_role_list current_company
		target_records = SupportRole.where(company: nil).or(SupportRole.where(company: current_company&.id)).where.not(id: 1)
		list = {}
		list[:options] = {values: target_records.ids, labels: target_records.map{|t| I18n.t("support_roles.#{t.role_case}")}}
		return list
	end

	def expired_year
		values = (Time.now.year..Time.now.year + 10).to_a
		list = {}
		list[:options] = {values: values,labels: values}
		return list
	end

	def user_type_pse
		values = ['N','J']
		labels = ['Persona Natural', 'Persona Jurídica']
		list = {}
		list[:options] = {values: values,labels: labels}
		return list
	end

	def user_type_pse_for_wompi
		values = ['0','1']
		labels = ['Persona Natural', 'Persona Jurídica']
		list = {}
		list[:options] = {values: values,labels: labels}
		return list
	end

	def bank_list_pse gateway
		bank_list = gateway.get_pse_bank_list
		values = nil
		labels = nil
		if gateway.instance_of?(WompiGateway)
			values = bank_list.map{|l| l['financial_institution_code']}
			labels = bank_list.map{|l| l['financial_institution_name']}
		else
			values = bank_list['banks'].map{|l| l['pseCode']}
			labels = bank_list['banks'].map{|l| l['description']}
		end
		list = {}
		list[:options] = {values: values,labels: labels}
		return list
	end

	def pais_payu
		values = ['BR','AR','CO','MX','PA','PE']
		labels = values.map{|v| I18n.t("payu.countries_of_payment.#{v}")}
		list = {}
		list[:options] = {values: values,labels: labels}
		return list
	end

	def debit_card_payu
		values = ['MASTERCARD','BCP','VISA','AMEX','DINERS','PAGOEFECTIVO','VISA_DEBIT','MASTERCARD_DEBIT']
		labels = values.map{|v| I18n.t("payu.payment_method.#{v}")}
		list = {}
		list[:options] = {values: values,labels: labels}
		return list
	end

	def document_type_payu
		values = ['CC','CE','NIT','TI','PP','RC','DE']
		labels = values.map{|v| I18n.t("payu.type_of_document.#{v}")}
		list = {}
		list[:options] = {values: values,labels: labels}
		return list
	end

	def document_type_wompi
		values = ['CC','NIT']
		labels = values.map{|v| I18n.t("payu.type_of_document.#{v}")}
		list = {}
		list[:options] = {values: values,labels: labels}
		return list
	end

	def payment_card_month_list
		values = ['01','02','03','04','05','06','07','08','09','10','11','12']
		list = {}
		list[:options] = {values: values, labels: values}
		return list
	end

	def months_number_list

		values = (1..12).to_a
		labels = values.map{ |i| lumni_month i}
		list = {}
		list[:options] = {values: values, labels: labels}
		return list
	end

	def nearby_years_list
		values = [Time.now.year]
		values += [Time.now.year - 1]
		values += [Time.now.year + 1]
		list = {}
		list[:options] = {values: values, labels: values}
		return list
	end

	def university_grade_period_list
		target_years = [Time.now.year]
		target_years += [Time.now.year - 1]
		target_years += [Time.now.year + 1]

		values = []

		target_years.each do |year|
			values += 4.times.map{|p| "#{year}-#{p + 1}"}
		end
		list = {}
		list[:options] = {values: values, labels: values}
		return list
	end

 	def find_label_from_list value, list
 		array_values = list.values.map{|v| v[:values]}.flatten
 		array_values = array_values.map(&:to_s)
 		array_labels = list.values.map{|v| v[:labels]}.flatten
 		array_labels = array_labels.map(&:to_s)
 		array_labels[array_values.index(value.to_s)]
 	end

	def validation_questionnaire_list
		values = ['mandatory','reactivation']
		list = {}
		list[:options] = {values: values, labels: values.map{|v| I18n.t('list.' + v)}}
		return list
	end

	def fullQuestionnaireList
		target_records = Questionnaire.kept
		list = {}
		list[:options] = {values: target_records.ids,labels: target_records.map{|t| t.name}}
		return list
	end

	def interviewFullList current_company
		target_records = Questionnaire.where(category: "interview",company_id: current_company.id)
		list = {}
		list[:options] = {values: target_records.ids,labels: target_records.map{|t| t.name}}
		return list
	end
	def legal_match_status_list
		values = ['active','inactive','downloaded','attached','canceled','archived']
		list = {}
		list[:options] = {values: values, labels: values.map{|v| I18n.t('list.' + v)}}
		return list
	end

	def modeling_type_list
		values = ['fixed_conditions','modeling_with_r','modeling_with_pricing_table', 'scholarship']
		list = {}
		list[:options] = {values: values, labels: values.map{|v| I18n.t('list.' + v)}}
		return list
	end

	def list_lumni_dashboards
		list = {}
		values = LumniDashboards.instance_methods
		list[:options] = {values: values, labels: values}
		return list
	end

	def scoring_questionnaire_list
		list = {}
		values = LumniScoring.instance_methods
		list[:options] = {values: values, labels: values}
		return list
	end

	def application_list
		target_values = ['origination', 'disbursement_request', 'courses', 'partial_scores', 'final_scores', 'cancellation_request', 'add_disbursement_modeling', 'diploma_delivery', 'funded_major', 'covid', 'manual_payment', 'income_information', 'conciliation']
		target_labels = target_values.map{|v| I18n.t('application.' + v)}
		list = {}
		list[:options] = {values: target_values, labels: target_labels}
		return list
	end

	
	def yes_no_list
		values = ['yes','no']
		list = {}
		list[:options] = {values: values, labels: values.map{|v| I18n.t("general.#{v}")}}		
		return list
	end
	def colombian_majors
		target_records = Major.all
		list = {} 
		list[:options] = {values: target_records.ids, labels: target_records.map{|u| u.name}}
		return list
	end

	def holberton_university_list
		target_records = Institution.select(:id,:name).joins(:major).where(id: 57096).distinct
		list = {}
		list[:options] = {values: target_records.ids, labels: target_records.map{|u| u.name}}
		return list
	end

	def colombian_institutions
		target_records = Institution.select('DISTINCT ON (institutions.name, institutions.id) institutions.id,institutions.name ').joins(:major,location: :country).where(locations: {geographies: {value: 'CO'}},legacy_type: "Institución Sede").order(:name)
		list = {} 
		list[:options] = {values: target_records.ids.uniq, labels: target_records.map{|u| u.name}}
		return list
	end

	def peruvian_institutions
		target_records = Institution.select('DISTINCT ON (institutions.name, institutions.id) institutions.id,institutions.name ').joins(:major,location: :country).where(locations: {geographies: {value: 'PE'}},legacy_type: "Institución Sede").order(:name)
		list = {} 
		list[:options] = {values: target_records.ids, labels: target_records.map{|u| u.name}}
		return list
	end

	def colombian_schools
		target_records = Institution.select('DISTINCT ON (institutions.name, institutions.id) institutions.id,institutions.name ').joins(:major,location: :country).where(locations: {geographies: {value: 'CO'}},legacy_type: "Colegios").order(:name)
		list = {} 
		list[:options] = {values: target_records.ids, labels: target_records.map{|u| u.name}}
		return list
	end


	def institution_group_list
		target_records = InstitutionGroup.kept
		list = {} 
		list[:options] = {values: target_records.ids, labels: target_records.map{|u| u.name}}
		return list
	end

	def questionnaire_type_list
		values = ['time_trial','survey','scoring','internal_check']
		list = {}
		list[:options] = {values: values, labels: values.map{|v| I18n.t('questionnaire.' + v)}}
		return list
	end


	def questionnaire_category_list
		values = ["application", "following_test", "satisfaction_survey", "initial_test", "selection_test", "scoring","interview",'origination_stop','review']
		list = {}
		list[:options] = {values: values, labels: values.map{|v| I18n.t('questionnaire.' + v)}}
		return list
	end

	def marital_status_list
		values = ['married','separated','single','civil_union','widowed']
		list = {}
		list[:options] = {values: values,labels: values.map{|v| I18n.t("list.#{v}")}}
		return list
	end

	def gender_list
		values = ['male','female']
		list = {}
		list[:options] = {values: values,labels: values.map{|v| I18n.t("general.#{v}")}}
		return list
	end

	def user_types
		values = ['potential_investor','corporative_investor','internal_project_account','client_partner','staff','student','test_student']
		list = {}
		list[:options] = {values: values, labels: values}
		return list
	end

	def notificationFuncionalityList
		values = NotificationCasesHelper.instance_methods
		list = {}
		list[:options] = {values: values, labels: values}
		return list
	end

	def project_cards_name_list
		values = ['on-hold','in-progress','under-review','done']
		list = {}
		list[:options] = {values: values, labels: values.map{|v| I18n.t('project.' + v)}}
		return list
	end

	def implementation_technology_phases_list
		values = ['review_requirements','adjust_changes','setup_platform']
		list = {}
		list[:options] = {values: values, labels: values}
		return list
	end

	def implementation_operation_phases_list
		values = ['create_fund','create_funding_opportunity','allocate_resources']
		list = {}
		list[:options] = {values: values, labels: values}
		return list
	end

	def implementation_financial_phases_list
		values = ['create_bank_account','receive_investment']
		list = {}
		list[:options] = {values: values, labels: values}
		return list
	end

	def implementation_research_phases_list
		values = ['adjust_model','update_model_info','create_fee_records','test_financial_modeling']
		list = {}
		list[:options] = {values: values, labels: values}
		return list
	end

	def implementation_legal_phases_list
		values = ['adjust_contract','adjust_legal_disclosures','create_legal_entity']
		list = {}
		list[:options] = {values: values, labels: values}
		return list
	end


	def business_closed_list
		target_records = BizdevBusiness.where(phase: 'closed', general_status: 'won')
		list = {}
		list[:options] = {values: target_records.ids, labels: target_records.map{|t| t.name}}
		return list
	end

	def migration_field_migration_methods
		values = LumniFieldMigration.instance_methods

		list = {}
		list[:options] = {values: values, labels: values}
		return list
	end

	def migration_field_type_options
		values = ['regular','function','references','fixed_value']
		list = {}
		list[:options] = {values: values,labels: values}
		return list
	end

	def cached_sf_field_list object
		Rails.cache.fetch([object],expires_in: 24.hours){sf_fields_list( object)}
	end

	def sf_fields_list object
		client = Restforce.new()
		general_description = client.describe(object)
		values = general_description.fields.map{|g| g.name}
		if values.include?('RecordTypeId')
			values += ['RecordType.Name'] 
		end

		current_migration = Migration.cached_find(params[:id])
		options = eval(current_migration.options.to_s)
		options = {} if options.nil?

		if !options[:additional_fields].nil?
			values += options[:additional_fields].map{|v| v.gsub ' ',''}
		end

		
		list = {}
		list[:sf_objects] = {values: values, labels: values}
		return list
	end

	def migration_status_list
		values = ['under_revision','migrate','force_migration','force_stop', 'error','stopped','done']
		list = {}
		list[:status] =  {values: values,labels: values}
		return list
	end

	def migration_type_list
		values = ['regular','method']
		list = {}
		list[:types] =  {values: values,labels: values}
		return list
	end

  def controllers_list
    controllerList = Rails.application.routes.routes.map do |route|
      (!route.defaults[:controller].nil? && !route.defaults[:controller].include?('/')) ? route.defaults[:controller] : nil
    end.uniq.compact
  end

  def models_list
    ModelList.get
  end

  def list_of_models
  	list = {}
  	list[:models] = {values: models_list, labels: models_list}
  	return list
  end


	def lumni_migration_list
		values = LumniMigration.instance_methods
		list = {}
		list[:methods] = {values: values, labels: values}
		return list
	end

	def migration_records_list
		target_records = Migration.kept
		values = target_records.map{|r| r.id}
		labels = target_records.map{|r| r.name}
		list = {}
		list[:migration] = {values: values, labels: labels} 
		return list
	end

	def sf_object_list
		client = Restforce.new()
		general_description = client.describe
		values = general_description.map{|g| g.name}
		list = {}
		list[:sf_objects] = {values: values, labels: values}
		return list
	end

	def business_general_status
		values = ['in_progress','stand_by','won','lost']
		list = {}
		list[:general_status] = {values: values, labels: values.map{|v| I18n.t('general.' + v)}}
		return list
	end

	def priority_list
		values = ['very_high','high','medium','low']
		list = {}
		list[:priority] = {values: values, labels: values.map{|v| I18n.t('general.' + v)}}
		return list
	end
	

	def bizDev_phases
		values = ['target', 'contract_made', 'pitch_done', 'in_negociation', 'documentation','closed']
		list = {}
		list[:phase] = {values: values, labels: values.map{|v| I18n.t('biz_dev.' + v)}} 
		return list
	end
	def empty_list
		list = {}
		list[:options] = {values: [],labels: []} 
		return list
	end

	def migration_actions_list
		values = ['institutions_and_majors','questionnaires_questions_and_answers']
		list = {}
		list[:options] = {values: values, labels: values}
		return list
	end

	def countriesList
		records = Geography.cached_all_countries
		list = {}
		list[:countries] = {values: records.map{|r| r.id}, labels: records.map{|r| r.label}}
		return list
	end

	def countriesAcademicList
		application = Application.cached_find(params[:id])
		records = application.countries
		list = {}
		list[:countries] = {values: records.map{|r| r.id}, labels: records.map{|r| r.label}}
		return list
	end

	def programs_by_institution institution_id, list_number
		target_records = Major.cached_major_group(institution_id,list_number)
		target_values = target_records.map{|r| r.id}
		target_labels = target_records.map{|r| r.name}
		list = {}
		list[:majors] = {values: target_values, labels: target_labels}
		return list
	end

	def regionsCitiesList country, region,options={}

		puts "These are te options from the country list: #{options}"
		if region.nil? || region == ''
			records = Geography.cached_subgroup(country)
		else
			records = Geography.cached_subgroup(region)
		end

		if options[:filter_list].nil?
			target_values = records.map{|r| r.id}
			target_labels = records.map{|r| r.label}
		else
			target_values = records.map{|r| options[:filter_list].include?(r.id.to_s) ? r.id : nil}.compact
			target_labels = records.map{|r| options[:filter_list].include?(r.id.to_s) ? r.label : nil}.compact
		end
				
		list = {}
		list[:cities] = {values: target_values, labels: target_labels}
		return list
	end
	def generalHelperList
		options = ListsHelper.instance_methods.sort
		list = {}
		list[:functionality] = {values: options, labels: options}
		return list
	end		
	def generalLegalLanguageHelperList
		options = LegalLanguageListHelper.instance_methods.sort
		list = {}
		list[:functionality] = {values: options, labels: options}
		return list
	end		

	def fundList current_company

		list = {}
		funds = Fund.where(company_id: current_company.cached_my_companies.ids).kept
		list[:funds] = {values: funds.map{|f| f.id}, labels: funds.map{|f| f.name}}
		return list
	end

	def teamStatusList
		list = {}
		options = ['active', 'inactive']
		list[:status] = {values: options, labels: options.map{|o| I18n.t('list.' + o)}}
		return list
	end

	def generalStatusList
		list = {}
		options = ['active', 'inactive']
		list[:status] = {values: options, labels: options.map{|o| I18n.t('list.' + o)}}
		return list
	end

	def statusFundingToken
		list = {}
		options = ['active', 'used']
		list[:status] = {values: options, labels: options.map{|o| I18n.t('list.' + o)}}
		return list
	end

	def legalDocumentTypeList
		list = {}
		options = ['just_information','eligibility_criteria','privacy_policy','terms_of_use','isa_contract_adult','isa_contract_young','adverse_action_notice',
			'application_and_solicitation','credit_history','ferpa','final_disclosure','information_sharing',
			'isa_approval_disclosure', 'military_lending','modification_letter','notice_to_married_in_wisconsin',
			'master_glba','self_certification','amendment_adult','amendment_young',
			'assignation_to_collection_house','good_standing_certificate','investment_funds_and_full_rooms_notification', 
			'annual_conciliation','billing_document', 'adult_promissory_note', 'young_promissory_note']
		list[:documentList] = {values: options, labels: options.map{|o| I18n.t('list.' + o)}}
		return list
	end

	def teamMembersList current_company
		list = {}
		team = current_company.cached_company_staff
		list[:users] = {values: team.map{ |t| t.id}, labels: team.map{|t| t.name} }
		return list
	end

	def signerList
		list = {}
		team = User.with_role(:legal_representative)
		list[:managers] = {values: team.map{ |t| t.id}, labels: team.map{|t| t.name} }
		return list

	end

	def companiesList
		list = {}
		company = Company.kept
		list[:companies] = {values: company.map{ |t| t.id}, labels: company.map{|t| t.name} }
		return list
	end

	def currencyList
		list = {}
		options =['USD','COP','PEN','CLP','MXN','ARS','EUR']
		list[:currencies] = {values: options, labels: options.map{|o| I18n.t('list.' + o)}}
		return list

	end

	def timezoneList
		list = {}
		timezone_list = { "International Date Line West" => "Etc/GMT+12", "Midway Island" => "Pacific/Midway", "American Samoa" => "Pacific/Pago_Pago", "Hawaii" => "Pacific/Honolulu", "Alaska" => "America/Juneau", "Pacific Time (US & Canada)" => "America/Los_Angeles", "Tijuana" => "America/Tijuana", "Mountain Time (US & Canada)" => "America/Denver", "Arizona" => "America/Phoenix", "Chihuahua" => "America/Chihuahua", "Mazatlan" => "America/Mazatlan", "Central Time (US & Canada)" => "America/Chicago", "Saskatchewan" => "America/Regina", "Guadalajara" => "America/Mexico_City", "Mexico City" => "America/Mexico_City", "Monterrey" => "America/Monterrey", "Central America" => "America/Guatemala", "Eastern Time (US & Canada)" => "America/New_York", "Indiana (East)" => "America/Indiana/Indianapolis", "Bogota" => "America/Bogota", "Lima" => "America/Lima", "Quito" => "America/Lima", "Atlantic Time (Canada)" => "America/Halifax", "Caracas" => "America/Caracas", "La Paz" => "America/La_Paz", "Santiago" => "America/Santiago", "Newfoundland" => "America/St_Johns", "Brasilia" => "America/Sao_Paulo", "Buenos Aires" => "America/Argentina/Buenos_Aires", "Montevideo" => "America/Montevideo", "Georgetown" => "America/Guyana", "Puerto Rico" => "America/Puerto_Rico", "Greenland" => "America/Godthab", "Mid-Atlantic" => "Atlantic/South_Georgia", "Azores" => "Atlantic/Azores", "Cape Verde Is." => "Atlantic/Cape_Verde", "Dublin" => "Europe/Dublin", "Edinburgh" => "Europe/London", "Lisbon" => "Europe/Lisbon", "London" => "Europe/London", "Casablanca" => "Africa/Casablanca", "Monrovia" => "Africa/Monrovia", "UTC" => "Etc/UTC", "Belgrade" => "Europe/Belgrade", "Bratislava" => "Europe/Bratislava", "Budapest" => "Europe/Budapest", "Ljubljana" => "Europe/Ljubljana", "Prague" => "Europe/Prague", "Sarajevo" => "Europe/Sarajevo", "Skopje" => "Europe/Skopje", "Warsaw" => "Europe/Warsaw", "Zagreb" => "Europe/Zagreb", "Brussels" => "Europe/Brussels", "Copenhagen" => "Europe/Copenhagen", "Madrid" => "Europe/Madrid", "Paris" => "Europe/Paris", "Amsterdam" => "Europe/Amsterdam", "Berlin" => "Europe/Berlin", "Bern" => "Europe/Zurich", "Zurich" => "Europe/Zurich", "Rome" => "Europe/Rome", "Stockholm" => "Europe/Stockholm", "Vienna" => "Europe/Vienna", "West Central Africa" => "Africa/Algiers", "Bucharest" => "Europe/Bucharest", "Cairo" => "Africa/Cairo", "Helsinki" => "Europe/Helsinki", "Kyiv" => "Europe/Kiev", "Riga" => "Europe/Riga", "Sofia" => "Europe/Sofia", "Tallinn" => "Europe/Tallinn", "Vilnius" => "Europe/Vilnius", "Athens" => "Europe/Athens", "Istanbul" => "Europe/Istanbul", "Minsk" => "Europe/Minsk", "Jerusalem" => "Asia/Jerusalem", "Harare" => "Africa/Harare", "Pretoria" => "Africa/Johannesburg", "Kaliningrad" => "Europe/Kaliningrad", "Moscow" => "Europe/Moscow", "St. Petersburg" => "Europe/Moscow", "Volgograd" => "Europe/Volgograd", "Samara" => "Europe/Samara", "Kuwait" => "Asia/Kuwait", "Riyadh" => "Asia/Riyadh", "Nairobi" => "Africa/Nairobi", "Baghdad" => "Asia/Baghdad", "Tehran" => "Asia/Tehran", "Abu Dhabi" => "Asia/Muscat", "Muscat" => "Asia/Muscat", "Baku" => "Asia/Baku", "Tbilisi" => "Asia/Tbilisi", "Yerevan" => "Asia/Yerevan", "Kabul" => "Asia/Kabul", "Ekaterinburg" => "Asia/Yekaterinburg", "Islamabad" => "Asia/Karachi", "Karachi" => "Asia/Karachi", "Tashkent" => "Asia/Tashkent", "Chennai" => "Asia/Kolkata", "Kolkata" => "Asia/Kolkata", "Mumbai" => "Asia/Kolkata", "New Delhi" => "Asia/Kolkata", "Kathmandu" => "Asia/Kathmandu", "Astana" => "Asia/Dhaka", "Dhaka" => "Asia/Dhaka", "Sri Jayawardenepura" => "Asia/Colombo", "Almaty" => "Asia/Almaty", "Novosibirsk" => "Asia/Novosibirsk", "Rangoon" => "Asia/Rangoon", "Bangkok" => "Asia/Bangkok", "Hanoi" => "Asia/Bangkok", "Jakarta" => "Asia/Jakarta", "Krasnoyarsk" => "Asia/Krasnoyarsk", "Beijing" => "Asia/Shanghai", "Chongqing" => "Asia/Chongqing", "Hong Kong" => "Asia/Hong_Kong", "Urumqi" => "Asia/Urumqi", "Kuala Lumpur" => "Asia/Kuala_Lumpur", "Singapore" => "Asia/Singapore", "Taipei" => "Asia/Taipei", "Perth" => "Australia/Perth", "Irkutsk" => "Asia/Irkutsk", "Ulaanbaatar" => "Asia/Ulaanbaatar", "Seoul" => "Asia/Seoul", "Osaka" => "Asia/Tokyo", "Sapporo" => "Asia/Tokyo", "Tokyo" => "Asia/Tokyo", "Yakutsk" => "Asia/Yakutsk", "Darwin" => "Australia/Darwin", "Adelaide" => "Australia/Adelaide", "Canberra" => "Australia/Melbourne", "Melbourne" => "Australia/Melbourne", "Sydney" => "Australia/Sydney", "Brisbane" => "Australia/Brisbane", "Hobart" => "Australia/Hobart", "Vladivostok" => "Asia/Vladivostok", "Guam" => "Pacific/Guam", "Port Moresby" => "Pacific/Port_Moresby", "Magadan" => "Asia/Magadan", "Srednekolymsk" => "Asia/Srednekolymsk", "Solomon Is." => "Pacific/Guadalcanal", "New Caledonia" => "Pacific/Noumea", "Fiji" => "Pacific/Fiji", "Kamchatka" => "Asia/Kamchatka", "Marshall Is." => "Pacific/Majuro", "Auckland" => "Pacific/Auckland", "Wellington" => "Pacific/Auckland", "Nuku'alofa" => "Pacific/Tongatapu", "Tokelau Is." => "Pacific/Fakaofo", "Chatham Is." => "Pacific/Chatham", "Samoa" => "Pacific/Apia" }
		list[:america] = {values: timezone_list.keys.map{|t| timezone_list[t].include?('America/') ? timezone_list[t] : nil }.compact,
							labels: timezone_list.keys.map{|t| timezone_list[t].include?('America/') ? t : nil }.compact}
		list[:atlantic] = {values: timezone_list.keys.map{|t| timezone_list[t].include?('Atlantic/') ? timezone_list[t] : nil }.compact,
							labels: timezone_list.keys.map{|t| timezone_list[t].include?('Atlantic/') ? t : nil }.compact}
		list[:europe] = {values: timezone_list.keys.map{|t| timezone_list[t].include?('Europe/') ? timezone_list[t] : nil }.compact,
							labels: timezone_list.keys.map{|t| timezone_list[t].include?('Europe/') ? t : nil }.compact}
		list[:africa] = {values: timezone_list.keys.map{|t| timezone_list[t].include?('Africa/') ? timezone_list[t] : nil }.compact,
							labels: timezone_list.keys.map{|t| timezone_list[t].include?('Africa/') ? t : nil }.compact}
		list[:asia] = {values: timezone_list.keys.map{|t| timezone_list[t].include?('Asia/') ? timezone_list[t] : nil }.compact,
							labels: timezone_list.keys.map{|t| timezone_list[t].include?('Asia/') ? t : nil }.compact}
		list[:pacific] = {values: timezone_list.keys.map{|t| timezone_list[t].include?('Pacific/') ? timezone_list[t] : nil }.compact,
							labels: timezone_list.keys.map{|t| timezone_list[t].include?('Pacific/') ? t : nil }.compact}
		return list
	end

	def countryList
		list = {}
		tempCountry = Country.kept
		list[:countries] = {values: tempCountry.map{|c| c.id},
							labels: tempCountry.map{|c| c.name} }
		return list

	end

	def legalStatusList
		list = {}
		options = ['under_revision','active','deprecated','archived','inactive']
		list[:status] = {values: options, labels: options.map{|o| I18n.t('list.' + o)}}
		return list

	end

	def roleList

		list = {}
		tempRole = Role.kept
		list[:roles] = {values: tempRole.map{|c| (c.name == 'student' || c.name == 'alpha') ? nil : c.name}.compact,
							labels: tempRole.map{|c| (c.name == 'student' || c.name == 'alpha') ? nil : c.name}.compact }
		return list

	end

	def legalAccessList
		list = {}
		options = ['general','private']
		list[:access] = {values: options, labels: options.map{|o| I18n.t('list.' + o)}}
		return list

	end

	def legalValidationList
		list = {}
		options = ['no_validation','sign_up','signature','optional_agree','mandatory_agree','identity_number','physical_support','scanned_support']
		list[:validation] = {values: options, labels: options.map{|o| I18n.t('list.' + o)}}
		return list

	end

	def legalActivationList
		list = {}
		options = ['replace_previous','create_new']
		list[:activation] = {values: options, labels: options.map{|o| I18n.t('list.' + o)}}
		return list

	end

	def legalParentList current_company
		list = {}
		tempDocs = LegalDocument.kept.where(company_id: current_company.id)
		list[:legal_parent] = {values: tempDocs.ids, labels: tempDocs.map{|d| d.name} }
		return list

	end

	def funding_opportunity_types
		list = {}
		options = ['open','closed']
		list[:types] = {values: options, labels: options.map{|o| I18n.t('list.' + o)}}
		return list
	end

	def elitibility_criteria_list
		list = {}
		tempDocs = LegalDocument.kept.where(document_type: 'eligibility_criteria')
		list[:eligibility_criteria] = {values: tempDocs.map{|d| d.id}, labels: tempDocs.map{|d| d.name} }
		return list
	end


	def migration_subfund_list
		list = {}
		client = Restforce.new()
		fundList =  client.query("select id, name,LMN_Pais__r.Name from LMN_Fondo__c where RecordTypeId ='0121a000000RJCoAAO'")


		list[:funds] = {values: fundList.map{|f| f.Id}, labels: fundList.map{|f| f.Name + ' (' + f.LMN_Pais__r.Name + ')'}}

		return list
	end

	def supervisorsList
		list = {}
		supervisorList = User.where(id: User.find(params[:id]).supervisors)
		list[:supervisor] = {values: supervisorList.map{|s| s.id},labels: supervisorList.map{|s| s.name}}
		return list
	end

	def selfSupervisorsList
		list = {}
		supervisorList = User.where(id: current_user.supervisors)
		list[:supervisor] = {values: ([current_user.id] + supervisorList.map{|s| s.id} ),labels: ([current_user.name] + supervisorList.map{|s| s.name} )} 
		return list
	end

	def headersList company_id = nil
		if !company_id.nil?
			current_company_id = company_id
		else
			current_company_id = current_company.id
		end
		list = {}
		headerList = CommunicationHeader.kept
		list[:header] = {values: headerList.map{|h| h.id},labels: headerList.map{|h| h.title }} 
		return list
	end

	def footersList company_id = nil
		if !company_id.nil?
			current_company_id = company_id
		else
			current_company_id = current_company.id
		end
		list = {}
		footerList = CommunicationFooter.kept
		list[:footer] = {values: footerList.map{|h| h.id},labels: footerList.map{|h| h.title }} 
		return list
	end

	def communicationCaseList company_id = nil
		if !company_id.nil?
			current_company_id = company_id
		else
			current_company_id = current_company.id
		end
		list = {}
		caseList = CommunicationCase.kept
		list[:case] = {values: caseList.map{|h| h.id},labels: caseList.map{|h| h.title }} 
		return list
	end

	def holdingMembers
		targetUsers = User.where(type_of_account: 'staff', status: 'active').kept
		list = {}
		list[:users] = {values: targetUsers.map{|u| u.id}, labels: targetUsers.map{|u| u.name}}
		return list
	end

	def fullTeam user_id
		target_user = User.cached_find(user_id)
		full_team = User.where(id: target_user.fullTeam).order(:first_name,:last_name)
		puts 'target_user.fullTeam: ' + target_user.fullTeam.to_s
		list = {}
		list[:team] = {values: full_team.map{|t| t.id}, labels: full_team.map{|t| t.name}}
		return list
	end

	def teamProfileList
		allProfiles = TeamProfile.kept
		list = {}
		list[:profiles] = {values: allProfiles.map{|p| p.id}, labels: allProfiles.map{|p| p.name} }
		return list

	end

	def formTemplatesList
		templates = FormTemplate.kept
		list = {}
		list[:templates] = {values: templates.ids, labels: templates.map{|t| t.name}}
		return list
	end

	def teamProfileList
		profiles = TeamProfile.kept
		list = {}
		list[:profiles] = {values: profiles.ids, labels: profiles.map{|p| p.name}}
		return list
	end

	def teamProfileList_roles
		profiles = TeamProfile.kept.where.not(id: params[:id])
		list = {}
		list[:profiles] = {values: profiles.ids, labels: profiles.map{|p| p.name}}
		return list
	end

	def template_attribute_list
		list = {}
		valuesList = ['required','hidden','list','legal_language','disabled','min','max','custom_label','multiple_dropdown','default_value','step', 'accept', 'tooltip', 'maxlength']
		translationList = valuesList.map{|v| I18n.t('form.' + v)}
		list[:attribute_types] = {values: valuesList, labels: translationList}
		return list
	end

	def template_format_list
		list = {}
		formatList = ['boolean','string','text','integer','float','decimal','plain_number',
			'percentage','currency','file','multiple_file','inet','date','datetime','reference','email',
			'editor','full_editor','countries','regions','cities','districts',
			'institution','majors']
		list[:format] = {values: formatList, labels: formatList}
		return list
	end

	def grid_list
		grid_values = (1..12).to_a
		list = {}
		list[:grid_values] = {values: grid_values, labels: grid_values}
		return list
	end

	def list_type_list
		list_type_options = ['values','functionality']
		options_translated = list_type_options.map{|o| I18n.t('list.' + o)}
		list = {}
		list[:list_type] = {values: list_type_options, labels: options_translated}
		return list
	end

	def list_of_lists
		fullList = FormList.kept
		listLabels = fullList.map{|list| list.translator(current_user.language)}
		list = {}
		list[:list_type] = {values: fullList.ids, labels: listLabels}
		return list
	end

	def origination_options_module_list
		target_values = ['form','questionnaire','legal_document','stop_to_check','scoring']
		target_labels = target_values.map{|v| I18n.t('origination.' + v) }
		list = {}
		list[:options] = {values: target_values,labels: target_labels}
		return list
	end

	def origination_section_form current_company
		target_models = LumniApplicationForms.instance_methods.map{|form| form.to_s.split('applicationForm').last}
		templates = FormTemplate.kept.where(object: target_models)
		target_values = templates.ids
		target_labels = templates.map{ |t| t.name }

		list = {}
		list[:templates] = {values: target_values, labels: target_labels}
		return list
	end

	def origination_section_questionnaire current_company
		questionnaires = Questionnaire.main.where(company_id: current_company.id)
		target_values = questionnaires.ids
		target_labels = questionnaires.map{ |t| t.name }

		list = {}
		list[:questionnaires] = {values: target_values, labels: target_labels}
		return list
	end

	def origination_section_stop_to_check current_company
		questionnaires = Questionnaire.main.where(company_id: current_company.id)
		target_values = questionnaires.ids
		target_labels = questionnaires.map{ |t| t.name }

		list = {}
		list[:questionnaires] = {values: target_values, labels: target_labels}
		return list
	end


	def origination_section_scoring current_company
		questionnaires = Questionnaire.main.where(company_id: current_company.id)
		target_values = questionnaires.ids
		target_labels = questionnaires.map{ |t| t.name }

		list = {}
		list[:questionnaires] = {values: target_values, labels: target_labels}
		return list
	end

	def origination_section_legal_document current_company
		legal_documents = LegalDocument.kept
		target_values = legal_documents.ids
		target_labels = legal_documents.map{ |t| t.name }

		list = {}
		list[:legal_documents] = {values: target_values, labels: target_labels}
		return list
	end

	def origination_full_list
		origination = Origination.kept
		target_values = origination.map{|o| o.id}
		target_labels = origination.map{|o| o.name}
		list = {}
		list[:origination] = {values: target_values, labels: target_labels}
		return list
	end

  def operation_status_list
    target_values = ['active', 'finished']
    target_labels = target_values.map{|v| I18n.t('income_information.' + v)}
		list = {}
		list[:options] = {values: target_values, labels: target_labels}
		return list
  end

  def contract_case_list
    target_values = ['undefined_term','Término fijo','Trabajo Informal','Prestacion de Servicios','Salaried employee','independent','informal_employment','Independiente','internship_or_practice','Término Indefinido','Obra o Labor','fixed_term','Contractor','Pasantia','Prestación de servicios','service_provision','Voluntariado','voluntary','Hourly employee','job_or_ labour','Pasantía']
    target_labels = target_values.map{|v| I18n.t('income_information.' + v)}
		list = {}
		list[:options] = {values: target_values, labels: target_labels}
		return list
  end

  def income_case_list
    target_values = ['dividends','benefits_by_pension_lan','capital_gain_or_loss','income_from_own_employment','business_income','self_employment','benefits_by_pension_plan','employment','business_income','tax_interest']
    target_labels = target_values.map{|v| I18n.t('income_information.' + v)}
		list = {}
		list[:options] = {values: target_values, labels: target_labels}
		return list
  end


	def student_route_list
		target_values = ['create_account','confirm_email','apply','contract_activation','student_activation','start_payments','end_payments']
		target_labels = target_values.map{|v| I18n.t('student_route.' + v)}
		list = {}
		list[:options] = {values: target_values, labels: target_labels}
		return list
	end

	def student_route_by_action_list action
		profiles = TeamProfile.where(action: action).kept
		target_labels = profiles.map{|p| p.name}
		list = {}
		list[:options] = {values: profiles.ids, labels: target_labels}
		return list
	end

	def all_funding_opportunities_list(current_company)
		target_records = current_company.all_funding_opportunities
		target_labels = target_records.map{|f| f.name}
	
		list = {}
		list[:options] = {values:target_records.ids, labels: target_labels}
		return list
	end
	
	def active_funding_opportunity_list(company_id)
		target_records = Company.cached_find(company_id).active_funding_opportunities
		target_labels = target_records.map{|f| f.name}
		list = {}
		list[:options] = {values:target_records.ids, labels: target_labels}
		return list
	end


	def credit_check_list
		target_records = LegalDocument.where(document_type: 'credit_history')
		list = {}
		list[:legal_document] = {values: target_records.ids, labels: target_records.map{|doc| doc.name}}
		return list
	end

	def contract_list current_company
		if current_company.url == 'localhost:3000'
			target_records = LegalDocument.where(document_type: ['isa_contract_adult','isa_contract_young'])
		else
			target_records = LegalDocument.where(document_type: ['isa_contract_adult','isa_contract_young'],company_id: current_company.id)
		end
		list = {}
		list[:options] = {values: target_records.ids, labels: target_records.map{|doc| doc.name}}
		return list
	end

	def adult_contract_list current_company
		if current_company.url == 'localhost:3000'
			target_records = LegalDocument.where(document_type: 'isa_contract_adult')
		else
			target_records = LegalDocument.where(document_type: 'isa_contract_adult',company_id: current_company.id)
		end
		list = {}
		list[:options] = {values: target_records.ids, labels: target_records.map{|doc| doc.name}}
		return list
	end

	def young_contract_list current_company
		if current_company.url == 'localhost:3000'
			target_records = LegalDocument.where(document_type: 'isa_contract_young')
		else
			target_records = LegalDocument.where(document_type: 'isa_contract_young',company_id: current_company.id)
		end
		list = {}
		list[:options] = {values: target_records.ids, labels: target_records.map{|doc| doc.name}}
		return list
	end

	def adult_promissory_note_list current_company
		if current_company.url == 'localhost:3000'
			target_records = LegalDocument.where(document_type: 'adult_promissory_note')
		else
			target_records = LegalDocument.where(document_type: 'adult_promissory_note',company_id: current_company.id)
		end
		list = {}
		list[:options] = {values: target_records.ids, labels: target_records.map{|doc| doc.name}}
		return list
	end

	def young_promissory_note_list current_company
		if current_company.url == 'localhost:3000'
			target_records = LegalDocument.where(document_type: 'young_promissory_note')
		else
			target_records = LegalDocument.where(document_type: 'young_promissory_note',company_id: current_company.id)
		end
		list = {}
		list[:options] = {values: target_records.ids, labels: target_records.map{|doc| doc.name}}
		return list
	end


	def adult_amendment_contract_list current_company
		if current_company.url == 'localhost:3000'
			target_records = LegalDocument.where(document_type: 'amendment_adult')
		else
			target_records = LegalDocument.where(document_type: 'amendment_adult',company_id: current_company.id)
		end
		list = {}
		list[:options] = {values: target_records.ids, labels: target_records.map{|doc| doc.name}}
		return list
	end

	def young_amendment_contract_list current_company
		if current_company.url == 'localhost:3000'
			target_records = LegalDocument.where(document_type: 'amendment_young')
		else
			target_records = LegalDocument.where(document_type: 'amendment_young',company_id: current_company.id)
		end
		list = {}
		list[:options] = {values: target_records.ids, labels: target_records.map{|doc| doc.name}}
		return list
	end


	def eligibility_criteria_list current_company
		target_records = LegalDocument.where(document_type: 'eligibility_criteria',company_id: current_company.id)
		list = {}
		list[:options] = {values: target_records.ids, labels: target_records.map{|doc| doc.name}}
		return list
	end

	def modeling_list
		target_records = Modeling.kept
		list = {}
		list[:options] = {values: target_records.ids,labels: target_records.map{|model| model.name}}
		return list
	end

	def funding_opportunity_status
		values = ['planned','approved','rejected','in_progress','finished','canceled']
		list = {}
		list[:options] = {values: values, labels: values.map{|v| I18n.t('list.' + v)}}
		return list
  end
  
  def cluster_group_type_list
    target_records = ResearchVariable.where(type_of_variable: "Filtro").kept
    list = {}
    list[:options] = {values: target_records.map{|v| v.acronym}, labels: target_records.map{|v| v.name}}
    list
  end

  def originations_name_list
    target_records = Origination.where(status: 'active').kept
    list = {}
    list[:options] = {values: target_records.map{|v| v.id}, labels: target_records.map{|v| v.name}}
    list
  end

end
