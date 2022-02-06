module LumniFieldMigration

	def fee_unique_date field_id, sf_info
		field = MigrationField.cached_find(field_id)
		result = nil
		case sf_info[field.sf_field]
		when 'Fecha Entrega Diploma'
			result = 'diploma_delivery_date'
		when 'Fecha Envío de contrato'
			result = 'contract_send_date'
		when 'R-Fecha Cobro Comisión Diseño'
			result = 'agreed_design_fee_date'
		when 'R-Fecha Prueba Selección'
			result = 'selection_test_date'
		end
		return result
	end



	def fee_start_date field_id, sf_info
		field = MigrationField.cached_find(field_id)
		result = nil
		case sf_info[field.sf_field]
		when 'Fecha de inicio'
			result = 'start_date'
		when 'Fecha Estudiante Activo Lumni'
			result = 'activation_date'
		when 'R-Fecha Inicio Repago'
			result = 'start_repayment_date'
		when 'R-Fecha Primera solicitud de desembolso'
			result = 'first_disbursement_date'
		end
		return result
	end


	def fee_end_date field_id, sf_info
		field = MigrationField.cached_find(field_id)
		result = nil
		case sf_info[field.sf_field]
		when 'Fecha límite'
			result = 'fund_limit_date'
		when 'Fecha salida del fondo'
			result = 'out_of_the_fund_date'
		when 'R-Fecha Inicio Repago'
			result = 'start_repayment_date'
		end
		return result
	end




	def fee_case_list field_id, sf_info
		field = MigrationField.cached_find(field_id)
		result = nil
		case sf_info[field.sf_field]
		when 'Comisión Mínima'
			result = 'minimum_fee'
		when 'Pago Periódico'
			result = 'periodic_fee'
		when 'Pago Único'
			result = 'single_payment'
		when 'Rango'
			result = 'range'
		end
		return result
	end

	def payment_agreement_status field_id, sf_info
		field = MigrationField.cached_find(field_id)
		result = nil
		case sf_info[field.sf_field]
		when 'Cobro Finalizado'
			result = 'ended'
		when 'En Revision'
			result = 'under_review'
		when 'Pagado'
			result = 'payed'
		when 'Refinanciado'
			result = 'refinanced'
		when 'Under review'
			result = 'under_review'
		when 'Vigente'
			result = 'active'
		end
		return result
	end

	def payment_agreement_case field_id, sf_info
		field = MigrationField.cached_find(field_id)
		result = nil
		case sf_info[field.sf_field]
		when 'Conciliacion'
			result = 'conciliation'
		when 'Liquidacion'
			result = 'termination'
		when 'Normalizacion'
			result = 'normalization'
		end
		return result
	end


	def disbursement_payment field_id, sf_info
		field = MigrationField.cached_find(field_id)
		result = nil
		case sf_info[field.sf_field]
		when 'Rechazado por Bancos'
			result = 'rejected_by_bank'
		when 'Enviado a pagos'
			result = 'sent_to_account'
		when 'Pagado'
			result = 'payed'
		when 'Pendiente'
			result = 'review'
		when 'Pendiente cuenta de cobro'
			result = 'waiting_for_university_support'
		when 'Enviado a Banco'
			result = 'sent_to_bank'
		when 'Rechazado por SM'
			result = 'rejected_by_sm'
		end
		return result
	end

	def disbursement_request_state field_id, sf_info
		field = MigrationField.cached_find(field_id)
		result = nil
		case sf_info[field.sf_field]
		when 'Enviado a Banco', 'Enviado a pagos','Pagado', 'Pendiente cuenta de cobro', 'Rechazado por Bancos'
			result = 'approved'
		when 'Pendiente'
			result = 'submitted'
		when 'Rechazado por SM'
			result = 'rejected'
		end
		return result
	end


	def disbursement_request_result field_id, sf_info
		field = MigrationField.cached_find(field_id)
		result = nil
		case sf_info[field.sf_field]
		when 'Enviado a Banco', 'Enviado a pagos','Pagado', 'Pendiente cuenta de cobro', 'Rechazado por Bancos'
			result = 'approved'
		when 'Pendiente'
			result = nil
		when 'Rechazado por SM'
			result = 'fail'
		end
		return result
	end


	def propper_name_migration field_id, sf_info
		field = MigrationField.cached_find(field_id)
		propper_name = sf_info[field.sf_field].to_s
		proper = ''
		propper_name.downcase.split(' ').each do |s|
			s[0] = s[0].capitalize
			proper += s + ' '
		end
		return proper
	end

	def company_by_country_code field_id, sf_info
		field = MigrationField.cached_find(field_id)
		return Company.joins(:country).where(countries: {international_code: sf_info[field.sf_field]}).first.id
	end

	def company_by_country_field_migration field_id, sf_info
		country_id = country_field_id(field_id,sf_info)
		company = Company.where(id: [2,3,4,5,6,11]).find_by_country_id(country_id)
		return company.id
	end

	def translate_list sf_array, rails_array, sf_value
		sf_array = sf_array.map{|v| I18n.transliterate(v.split.join(' ').downcase)}
		sf_value = I18n.transliterate(sf_value.to_s.split.join(' ').downcase)

		result = nil
		position = sf_array.index(sf_value)
		if !position.nil?
			result = rails_array[position]
		end
		return result
	end

	def country_field_id field_id, sf_info
		field = MigrationField.cached_find(field_id)
		client = Restforce.new()
		sf_research_data = client.query("select Id,LastModifiedDate, LMN_CodigoPais__c,Name from LMN_Poblaciones__c where Id='#{sf_info[field.sf_field]}'")
		country = Country.find_by_international_code(sf_research_data.first.LMN_CodigoPais__c)
		return country.id
	end

	def disbursement_status field_id, sf_info
		field = MigrationField.cached_find(field_id)
		result = nil
		case sf_info[field.sf_field]
		when 'Anulado'
			result = 'canceled'
		when 'Canceled'
			result = 'canceled'
		when 'Con solicitud'
			result = 'requesting'
		when 'Generado'
			result = 'generated'
		when 'Pagado'
			result = 'payed'
		end
		return result

	end



	def income_case field_id, sf_info
		field = MigrationField.cached_find(field_id)
		result = nil
		case sf_info[field.sf_field]
		when 'Beneficios por plan de pensión'
			result = 'benefits_by_pension_plan'
		when 'Dividendos'
			result = 'dividends'
		when 'Empleo'
			result = 'employment'
		when 'Ganancia o perdida por capital'
			result = 'capital_gain_or_loss'
		when 'Ingreso por empleo propio'
			result = 'self_employment'
		when 'Ingreso por negocios'
			result = 'business_income'
		when 'Intereses por impuesto'
			result = 'financial_investement'
		end
		return result

	end

	def billing_document_status field_id, sf_info
		field = MigrationField.cached_find(field_id)
		result = nil
		case sf_info[field.sf_field]
		when 'En revisión'
			result = 'under_review'
		when 'Pagado'
			result = 'payed'
		when 'Pago parcial'
			result = 'partial_payment'
		when 'Pendiente de pago'
			result = 'active'
		end
		return result

	end	 



	def billing_detail_case field_id, sf_info
		field = MigrationField.cached_find(field_id)
		result = nil

		if sf_info['LMN_tipoDetalle__c'] == 'Multa'
			result = 'penalty'
		else
			case sf_info[field.sf_field]
			when 'Acuerdo de pago por Conciliacion', 'Acuerdo de pago por Liquidacion', 'Acuerdo de pago por Normalizacion'
				result = 'payment_agreement'
			when 'Cultura de pago', 'Cultura de Pago'
				result = 'nominal_payment'
			when 'Cuota Repago'
				result = 'repayment'
			when 'Penalty Fee'
				result = 'penalty'
			else
				result = 'repayment'
			end
		end
		return result

	end	 






	def isa_form_account field_id, sf_info
		field = MigrationField.cached_find(field_id)
		account_id = sf_info[field.sf_field]
		if !User.find_by_external_id(account_id).isa.first.nil?
			target_id = User.find_by_external_id(account_id).isa.first.id
		else
			target_id = nil
		end
		return target_id
	end

	def billing_document_year field_id, sf_info
		field = MigrationField.cached_find(field_id)
		sf_info[field.sf_field].to_date.year
	end
	 
	def billing_document_month field_id, sf_info
		field = MigrationField.cached_find(field_id)
		sf_info[field.sf_field].to_date.month
	end

	def year_from_date field_id, sf_info
		field = MigrationField.cached_find(field_id)
		sf_info[field.sf_field].to_date.year
	end

	def month_from_date field_id, sf_info
		field = MigrationField.cached_find(field_id)
		sf_info[field.sf_field].to_date.month
	end

	def billing_detail_year field_id, sf_info
		field = MigrationField.cached_find(field_id)
		sf_info[field.sf_field].split('-')[1].to_i
	end

	def billing_detail_month field_id, sf_info
		field = MigrationField.cached_find(field_id)
		sf_info[field.sf_field].split('-')[0].to_i
	end



	def reference_validation_status field_id, sf_info
		field = MigrationField.cached_find(field_id)
		result = nil
		case sf_info[field.sf_field]
		when 'Rechazado'
			result = 'rejected'
		when 'Verificado'
			result = 'verified'
		end
		return result

	end









	def academic_periodicity field_id,sf_info
		field = MigrationField.cached_find(field_id)
		result = nil
		case sf_info[field.sf_field]
		when 'Anual'
			result = 12
		when 'Bimestral'
			result = 2
		when 'Cuatrimestral'
			result = 4
		when 'Mensual'
			result = 1
		when 'Semestral'
			result = 6
		when 'Trimestral'
			result = 3
		end
		return result

	end

	def is_not_nil field_id,sf_info
		field = MigrationField.cached_find(field_id)
		!sf_info[field.sf_field].nil?
	end

	def si_no_nil field_id,sf_info
		field = MigrationField.cached_find(field_id)
		result = nil
		case sf_info[field.sf_field]
		when 'Si'
			result = true
		when 'No'
			result = false
		end
		return result
	end

	def true_to_active field_id, sf_info
		field = MigrationField.cached_find(field_id)
		if sf_info[field.sf_field]
			result = 'active'
		else
			result = 'inactive'
		end
		return result
	end

	def finishe_major_check field_id, sf_info
		field = MigrationField.cached_find(field_id)
		result = false
		if !sf_info[field.sf_field].nil? && !sf_info[field.sf_field].to_date.nil?
			result = true
		end
		return result
	end

	def record_is_nil_migration field_id,sf_info
		field = MigrationField.cached_find(field_id)
		return sf_info[field.sf_field].nil? || sf_info[field.sf_field] == ''
	end


	def record_not_nil_migration field_id,sf_info
		field = MigrationField.cached_find(field_id)
		return !sf_info[field.sf_field].nil? || sf_info[field.sf_field] != ''
	end


	def legal_document_from_fund field_id, sf_info
		field = MigrationField.cached_find(field_id)
		result = nil
		case field.sf_field
		when 'LMN_PlantillaContratoMenor__c','LMN_PlantillaContratoIIMenor__c','LMN_AnexosContratoMenor__c'
			result = sf_info['LMN_PlantillaContratoMenor__c'].to_s + sf_info['LMN_PlantillaContratoIIMenor__c'].to_s + sf_info['LMN_AnexosContratoMenor__c'].to_s
		when 'LMN_PlantillaContratoMayor__c','LMN_PlantillaContratoIIMayor__c','LMN_AnexosContratoMayor__c'
			result = sf_info['LMN_PlantillaContratoMayor__c'].to_s + sf_info['LMN_PlantillaContratoIIMayor__c'].to_s + sf_info['LMN_AnexosContratoMayor__c'].to_s
		when 'LMN_PlanillaOtroSi__c'
			result = sf_info['LMN_PlanillaOtroSi__c'].to_s
		when 'LMN_PlanillaOtroSiMenores__c'
			result = sf_info['LMN_PlanillaOtroSiMenores__c'].to_s
		when 'LMN_PoliticasPrivacidad__c'
			result = sf_info['LMN_PoliticasPrivacidad__c'].to_s
		when'LMN_TerminosCondiciones__c'
			result = sf_info['LMN_TerminosCondiciones__c'].to_s
		when 'LMN_PerfilEstudiante__c'
			result = sf_info['LMN_PerfilEstudiante__c'].to_s
		end
		return result

	end

	def legal_document_name_from_fund field_id, sf_info
		field = MigrationField.cached_find(field_id)
		result = nil
		case field.sf_field
		when 'LMN_PlantillaContratoMenor__c','LMN_PlantillaContratoIIMenor__c','LMN_AnexosContratoMenor__c'
			result = 'Contrato Menores Fondo ' + sf_info['Name']
		when 'LMN_PlantillaContratoMayor__c','LMN_PlantillaContratoIIMayor__c','LMN_AnexosContratoMayor__c'
			result = 'Contrato Mayores Fondo ' + sf_info['Name']
		when 'LMN_PlanillaOtroSi__c'
			result = 'Otro Si Mayores Fondo ' + sf_info['Name']
		when 'LMN_PlanillaOtroSiMenores__c'
			result = 'Otro Si Menores Fondo ' + sf_info['Name']
		when 'LMN_PoliticasPrivacidad__c'
			result = 'Políticas De Privacidad Fondo ' + sf_info['Name']
		when'LMN_TerminosCondiciones__c'
			result = 'Términos Y Condiciones Fondo ' + sf_info['Name']
		when 'LMN_PerfilEstudiante__c'
			result = 'Perfil del estudiante ' + sf_info['Name']
		end
		return result
	end


	def legal_document_type_from_fund field_id, sf_info
		field = MigrationField.cached_find(field_id)
		result = nil
		case field.sf_field
		when 'LMN_PlantillaContratoMenor__c','LMN_PlantillaContratoIIMenor__c','LMN_AnexosContratoMenor__c'
			result = 'isa_contract_young'
		when 'LMN_PlantillaContratoMayor__c','LMN_PlantillaContratoIIMayor__c','LMN_AnexosContratoMayor__c'
			result = 'isa_contract_adult'
		when 'LMN_PlanillaOtroSiMenores__c'
			result = 'amendment_young'
		when 'LMN_PlanillaOtroSi__c'
			result = 'amendment_adult'
		when 'LMN_PoliticasPrivacidad__c'
			result = 'privacy_policy'
		when'LMN_TerminosCondiciones__c'
			result = 'terms_of_use'
		when'LMN_PerfilEstudiante__c'
			result = 'eligibility_criteria'
		end
		return result

	end

	def funding_opportunity_status field_id, sf_info
		sf_array 	= ["Aprobada", "Rechazada", "Planeada", "En proceso", "Finalizada","Cancelada"]
		rails_array = ['approved','rejected','planned','in_progress','finished','canceled']
		result = translate_list( sf_array, rails_array, sf_info['LMN_Estado__c'])
		return result
	end

	def funding_opportunity_type field_id, sf_info
		sf_array 	= ["Cerrada", "Abierta"]
		rails_array = ['closed','open']
		result = translate_list( sf_array, rails_array, sf_info['LMN_TipoConvocatoria__c'])
		return result
	end

	def funding_opportunity_adult_contract field_id, sf_info
		contract = LegalDocument.where(external_id: (sf_info['LMN_Fondo__c'] + '_12'),document_type: 'isa_contract_adult').first
		if contract.nil?
			fund = Fund.where(external_id: sf_info['LMN_Fondo__c']).first
			contract = LegalDocument.where(external_id: (fund.fund.external_id + '_12'),document_type: 'isa_contract_adult').first if !fund.fund_id.nil?
		end
		result = contract.nil? ? nil : contract.id
		return result
	end


	def funding_opportunity_young_contract field_id, sf_info
		contract = LegalDocument.where(external_id: (sf_info['LMN_Fondo__c'] + '_11'),document_type: 'isa_contract_young').first
		if contract.nil?
			fund = Fund.where(external_id: sf_info['LMN_Fondo__c']).first
			contract = LegalDocument.where(external_id: (fund.fund.external_id + '_11'),document_type: 'isa_contract_young').first if !fund.fund_id.nil?
		end
		result = contract.nil? ? nil : contract.id
		return result
	end

	def funding_opportunity_young_amendment field_id, sf_info
		contract = LegalDocument.where(external_id: (sf_info['LMN_Fondo__c'] + '_13'),document_type: 'amendment_young').first
		if contract.nil?
			fund = Fund.where(external_id: sf_info['LMN_Fondo__c']).first
			contract = LegalDocument.where(external_id: (fund.fund.external_id + '_13'),document_type: 'amendment_young').first if !fund.fund_id.nil?
		end
		result = contract.nil? ? nil : contract.id
		return result
	end


	def funding_opportunity_adult_amendment field_id, sf_info
		contract = LegalDocument.where(external_id: (sf_info['LMN_Fondo__c'] + '_14'),document_type: 'amendment_adult').first
		if contract.nil?
			fund = Fund.where(external_id: sf_info['LMN_Fondo__c']).first
			contract = LegalDocument.where(external_id: (fund.fund.external_id + '_14'),document_type: 'amendment_adult').first if !fund.fund_id.nil?
		end
		result = contract.nil? ? nil : contract.id
		return result
	end

	def funding_opportunity_eligibility_criteria field_id, sf_info
		contract = LegalDocument.where(external_id: (sf_info['LMN_Fondo__c'] + '_18'),document_type: 'eligibility_criteria').first
		if contract.nil?
			fund = Fund.where(external_id: sf_info['LMN_Fondo__c']).first
			contract = LegalDocument.where(external_id: (fund.fund.external_id + '_18'),document_type: 'eligibility_criteria').first if !fund.fund_id.nil?
		end
		result = contract.nil? ? nil : contract.id
		return result
	end


	def user_type_migration field_id, sf_info
		sf_array 	= ["Client-Partner", "Estudiante","Internal Project Account","Inversionista Corporativo"]
		rails_array = ['client_partner','student','internal_project_account','corporative_investor']
		result = translate_list( sf_array, rails_array, sf_info['RecordType.Name'])
		return result
	end

	def company_by_fund field_id, sf_info
		field = MigrationField.cached_find(field_id)
		fund = Fund.find_by_external_id(sf_info[field.sf_field])
		return fund.company_id
	end

	def company_by_fund field_id, sf_info
		field = MigrationField.cached_find(field_id)
		fund = Fund.find_by_external_id(sf_info[field.sf_field])
		return fund.company_id
	end

	def language_by_fund field_id, sf_info
		field = MigrationField.cached_find(field_id)
		company = Fund.find_by_external_id(sf_info[field.sf_field]).company
		return company.default_language
	end

	def timezone_by_fund field_id, sf_info
		field = MigrationField.cached_find(field_id)
		company = Fund.find_by_external_id(sf_info[field.sf_field]).company
		return company.timezone
	end

	def user_email field_id, sf_info
		field = MigrationField.cached_find(field_id)
		email = sf_info[field.sf_field]
		user = User.where(email: email).where.not(external_id: sf_info['Id'])
		if email.nil? || email == '' || user.count > 0
			email = sf_info['Id'] + '@example.com'
		end
		return email
	end

	def country_field field_id, sf_info
		field = MigrationField.cached_find(field_id)
		country = Geography.find_by_external_id(sf_info[field.sf_field]).value
		return country
	end

	def gender field_id, sf_info
		field = MigrationField.cached_find(field_id)
		sf_array 	= ['Femenino','Masculino']
		rails_array = ['female','male']
		result = translate_list( sf_array, rails_array, sf_info[field.sf_field])
		return result
	end

	def marital_status field_id, sf_info
		field = MigrationField.cached_find(field_id)
		sf_array 	= ['Casado','Convivencia','Divorciado','Separado','Soltero','Unión libre','Viudo']
		rails_array = ['married','cohabiting','divorced','separated','single','civil_union','widowed']
		result = translate_list( sf_array, rails_array, sf_info[field.sf_field])
		return result
		
	end

	def funding_opportunity_for_applications field_id, sf_info
		field = MigrationField.cached_find(field_id)
		result = nil
		reference_record = eval(field.object_reference).find_by_external_id(sf_info['LMN_IdCuentaPOS__r.LMN_IdConvocatoria__c'])
		if sf_info[field.sf_field].nil? || sf_info[field.sf_field] == '' || reference_record.nil?
			reference_record = eval(field.object_reference).find_by_external_id(sf_info[field.sf_field])
		end
		result = reference_record.id if !reference_record.nil?
		return result
	end

	def who_pays_student_expenses field_id, sf_info
		field = MigrationField.cached_find(field_id)
		sf_array 	= ['Conocido','El Estado','Mi pareja','Sus padres','Sus padres y el Estado','Sus padres y un familiar',
			'Un familiar','Un Familiar y el Estado','Usted','Usted y el Estado','Usted y sus padres','Usted y un familiar']
		rails_array = ['acquaintance','goverment','partner','parents','parents_and_goverment','parents_and_family',
			'family','family_and_goverment','you','you_and_goverment','you_and_parents','you_and_family']
		result = translate_list( sf_array, rails_array, sf_info['LMN_PostulacionIF__r.LMN_QuienRespondeEconomicamente__c'])
		return result
	end

	def user_for_financial_info field_id, sf_info
		field = MigrationField.cached_find(field_id)
		user = User.find_by_external_id(sf_info["LMN_PostulacionIF__r.LMN_IdCuentaPOS__c"])
		return user.id
	end


	def user_for_school_info field_id, sf_info
		field = MigrationField.cached_find(field_id)
		user = User.find_by_external_id(sf_info["LMN_Postulacion__c.LMN_IdCuentaPOS__c"])
		return user.id
	end


	def user_for_university_info field_id, sf_info
		field = MigrationField.cached_find(field_id)
		user = User.find_by_external_id(sf_info["LMN_PostulacionIFA__r.LMN_IdCuentaPOS__c"])
		return user.id
	end


	def other_university_check_university_info field_id, sf_info
		field = MigrationField.cached_find(field_id)
		result = !(sf_info["LMN_OtroColegio__c"].nil? || sf_info["LMN_OtroColegio__c"] == '')
		return result
	end

	def debt_what_for field_id,sf_info
		field = MigrationField.cached_find(field_id)
		sf_array 	= ["Gastos del hogar","Manutención personas a cargo","Objetos personales","Transporte",
			"Alimentación","Otros","Tarjeta de Crédito","Crédito Hipotecario","Crédito Automotriz","Crédito de Nómina",
			"Crédito en tienda","Actividades de entretenimiento","Actividades academicas","Manutencion personas a cargo",
			"Alimentacion","Otro","Seguros"]

		rails_array = ['home_expenses','dependent_living_expenses','personal_goods', 'transportation_costs',
			'food','other','credit_card','mortgage_credit','automobiles','payroll_deductions',
			'on_credit','entertainment','academic_activities','dependent_living_expenses',
			'food','other','insurances']

		result = []
		if !sf_info[field.sf_field].nil?
			sf_info[field.sf_field].split(';').each do |partial_result|
				result += [translate_list( sf_array, rails_array, partial_result)]
			end
		end

		return result.join(';')
	end

	def student_goods field_id,sf_info
		field = MigrationField.cached_find(field_id)
		sf_array 	= ["Vivienda","Carro","Computador" "Celular","Moto"]

		rails_array = ['house','car','computer','mobile','motorcycle']

		result = []
		if !sf_info[field.sf_field].nil?
			sf_info[field.sf_field].split(';').each do |partial_result|
				result += [translate_list( sf_array, rails_array, partial_result)]
			end
		end
		return result.join(';')

	end

	def financial_products field_id,sf_info
		field = MigrationField.cached_find(field_id)
		sf_array 	= ["Cuenta de Ahorro","Creditos","Tarjeta de Credito","Cuenta Corriente","Créditos","Tarjeta de crédito"]

		rails_array = ['saving_account','loans','credit_card','current_account','loans','credit_card']

		result = []
		if !sf_info[field.sf_field].nil?
			sf_info[field.sf_field].split(';').each do |partial_result|
				result += [translate_list( sf_array, rails_array, partial_result)]
			end
		end
		return result.join(';')

	end

	def student_source_of_income_migration field_id,sf_info
		field = MigrationField.cached_find(field_id)
		sf_array 	= ["Dinero que me da mi familia","Trabajos ocasionales","Negocios personales","Trabajo tiempo completo",
			"Trabajo tiempo parcial","Subsidio del estado","Dinero que me dan otras personas"]

		rails_array = ['family_support','temporal_work','personal_business','full_time_employ',
			'partial_time_employ','federal_aid','other_people']

		result = []
		if !sf_info[field.sf_field].nil?
			sf_info[field.sf_field].split(';').each do |partial_result|
				result += [translate_list( sf_array, rails_array, partial_result)]
			end
		end
		return result.join(';')

	end


	def student_other_source_of_income_migration field_id,sf_info
		field = MigrationField.cached_find(field_id)
		sf_array 	= ["Crédito Bancario","Familiar","Trabajar","Vender algo","ICETEX"]

		rails_array = ['bank_loan','family_loan','work','sells','federal_credit']

		result = []
		if !sf_info[field.sf_field].nil?
			sf_info[field.sf_field].split(';').each do |partial_result|
				result += [translate_list( sf_array, rails_array, partial_result)]
			end
		end
		return result.join(';')

	end


	def academic_status_school_migration field_id,sf_info
		field = MigrationField.cached_find(field_id)
		sf_array 	= ["1","2","3","4","5 o más","No se ha graduado"]
		rails_array = ['graduated','graduated','graduated','graduated','graduated','studying']
		result = translate_list( sf_array, rails_array, sf_info[field.sf_field])
		return result
	end

	def major_status_migration field_id,sf_info
		field = MigrationField.cached_find(field_id)
		sf_array 	= ['true','false']
		rails_array = ['active','inactive']
		result = translate_list( sf_array, rails_array, sf_info[field.sf_field])
		return result
	end

	def type_of_term_for_university_info field_id,sf_info
		field = MigrationField.cached_find(field_id)
		sf_array 	= ['Anual','Bimentral','Cuatrimestral','Mensual','Semestral','Trimestral']
		rails_array = ['annual','bimonthly','four_months','monthly','biannual','quarterly']
		result = translate_list( sf_array, rails_array, sf_info[field.sf_field])
		return result
	end

	def university_program_status_migration field_id,sf_info
		field = MigrationField.cached_find(field_id)
		sf_array 	= ['Aplazado','Egresado','Estudiando','Expulsado','Retirado']
		rails_array = ['paused','finished','studing','expelled','withdrawn']
		result = translate_list( sf_array, rails_array, sf_info[field.sf_field])
		return result
	end

	def disbursement_type_migration field_id,sf_info
		field = MigrationField.cached_find(field_id)
		sf_array 	= ['Bono Académico','Manutención','Matrícula']
		rails_array = ['academic_bonus','living_expenses','tuition']
		result = translate_list( sf_array, rails_array, sf_info[field.sf_field])
		return result
	end

	def isa_status_migration field_id,sf_info
		field = MigrationField.cached_find(field_id)
		if !sf_info[field.sf_field].nil?
			result = 'inactive'
		else
			result = 'active'
		end
		return result
	end


	def academic_level_children_migration  field_id,sf_info
		field = MigrationField.cached_find(field_id)
		sf_array 	= ["Tecnológico incompleto", "Ninguno", "Primaria Completa", 
			"Primaria Incompleta", "Técnico incompleto", "Bachillerato Completo", 
			"Bachillerato Incompleto", "Universitario incompleto", "Universitario completo", 
			"Técnico completo", "Tecnológico completo", "preescolar", "bàsica incompleta", "media incompleta", 
			"bàsica completa", "secundaria incompleta", "secundaria completa", "preparatoria incompleta", 
			"Técnico Superior Incompleta", "Posgrado incompleto", "Posgrado completo", "Técnico Superior Completa"]
		rails_array = ['tecnologo_incomplete','none','primary_complete',
			'primary_incomplete','tecnico_incomplete','school_complete',
			'school_incomplete','university_incomplete','university_complete',
			'tecnico_complete','tenologo_complete','kinder','basic_incomplete','media_incomplete',
			'basic_complete','school_incomplete','school_complete','school_incomplete',
			'tecnico_superior_incomplete','graduate_incomplete','graduate_complete','tecnico_superior_complete']
		result = translate_list( sf_array, rails_array, sf_info[field.sf_field])
		return result
	end

	def children_gender_migration field_id,sf_info
		field = MigrationField.cached_find(field_id)
		sf_array 	= ['Femenino','Masculino']
		rails_array = ['male','female']
		result = translate_list( sf_array, rails_array, sf_info[field.sf_field])
		return result
	end

	def get_sf_array object, field
		client = Restforce.new()
		target_data = client.query("select #{field} from #{object}")
		result = target_data.map{|a| a[field]}.uniq
		return result
	end

	def disability_type_migration field_id,sf_info
		field = MigrationField.cached_find(field_id)
		sf_array 	= ["Cognitiva", "Sensorial", "Motriz"]
		rails_array = ['cognitive','sensory','motor']
		result = translate_list( sf_array, rails_array, sf_info[field.sf_field])
		return result
	end

	def language_for_staff field_id,sf_info
		field = MigrationField.cached_find(field_id)
		return sf_info[field.sf_field].split('_').first
	end








end
