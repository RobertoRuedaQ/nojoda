module LumniMigration
	include LumniFieldMigration
	def extra_checks
		fix_disbursement_request_match_at_sf
	end


	def refresh_disbursement_request some_input
		#MigrationAsync.perform_async('refresh_disbursement_request',nil)
		DisbursementRequest.all.each do |request|
			ModelClassesAsync.perform_async('DisbursementRequest', 'touch', request.id)
		end
	end

	def refresh_billing_documents some_input
		#MigrationAsync.perform_async('refresh_billing_documents',nil)
		BillingDocument.where(year: 2020, month:4).each do |billing_document|
			ModelClassesAsync.perform_async('BillingDocument', 'save', billing_document.id)
		end
	end


	def migrate_payment_mass_doc_payments some_input
		#MigrationAsync.perform_async('migrate_payment_mass_doc_payments',nil)
		PaymentMassDoc.joins(:payment_mass_detail).where.not(payment_mass_details: {external_id: nil}).each do |doc|
			ModelClassesAsync.perform_async('PaymentMassDoc', 'search_payment', doc.id)
		end
	end


	def migrate_payment_mass some_input
		#MigrationAsync.perform_async('migrate_payment_mass',nil)
		target_ids = PaymentMassDetail.where.not(billing_document_id: nil).or(PaymentMassDetail.where.not(payment_id: nil)).ids.uniq
		target_ids.each do |target_id|
			ModelClassesAsync.perform_async('PaymentMassDetail', 'migrate_to_new_structure', target_id)
		end
	end

	def set_equivalency some_input
		# MigrationAsync.perform_async('set_equivalency',nil)
		query = 'SELECT Id, LMN_Porcion_Cuota_Aplicar__c, LMN_PorcionCuotaAplicar__c FROM LMN_DetalleCobro__c WHERE LMN_Porcion_Cuota_Aplicar__c!=null'
		client = Restforce.new
		porciones = client.query(query)


		porciones.each do |porcion|
			detalle = BillingDocumentDetail.find_by_external_id(porcion.Id)
			if !detalle.nil?
				MigrationAsync.perform_async('individual_equivalency',[detalle.id,porcion.LMN_PorcionCuotaAplicar__c,porcion.LMN_Porcion_Cuota_Aplicar__c])
			end
		end
	end

  def individual_equivalency target_array
  	detalle = BillingDocumentDetail.cached_find(target_array.first)
    detalle.update({equivalency_covered: target_array.second, payment_equivalency: target_array.third})
  end


	def update_billing_document_status some_input
		#MigrationAsync.perform_async('update_billing_document_status',nil)
		BillingDocumentDetail.all.each do |detail|
			ModelClassesAsync.perform_async('BillingDocumentDetail', 'save', detail.id)
		end
	end

	def update_student_id some_input
		#MigrationAsync.perform_async('update_student_id',nil)
		done = User.joins(:personal_information).where('users.identification_number = personal_informations.identification_number').ids.uniq
		all_ids = User.joins(:personal_information).where.not(personal_informations: {identification_number: nil}).ids.uniq
		to_fix = all_ids - done

		to_fix.each do |target_id|
			user = User.includes(:personal_information).find(target_id)
			user.update(identification_number: user.personal_information.identification_number)
		end
	end

	def update_payment_match some_input
		#MigrationAsync.perform_async('update_payment_match',nil)
		PaymentMatch.joins(:billing_document_detail).where(billing_document_details: {applied_value: nil}).map(&:touch)
	end

	def fix_disbursement_request_match_at_sf
		wrong_disbursement_requests_query = 'SELECT Id, LMN_IdDesembolso__r.LMN_ContratoDSB__r.LMN_CuentaCTT__c, LMN_IdDesembolso__r.LMN_Periodo__c  FROM LMN_SolicitudDesembolsos__c WHERE LMN_IdDesembolso__r.LMN_ContratoDSB__r.LMN_Activo__c = FALSE'
		active_contract_query = "SELECT Id, LMN_CuentaCTT__c FROM LMN_Contrato__c WHERE LMN_Activo__c = TRUE AND RecordType.Name='Contrato Activo'"
		active_disbursements_query = "SELECT Id, LMN_ContratoDSB__c,LMN_Periodo__c FROM LMN_Desembolso__c WHERE LMN_ContratoDSB__r.LMN_Activo__c = TRUE AND LMN_ContratoDSB__r.RecordType.Name='Contrato Activo'"

		client = Restforce.new()
		requests = client.query(wrong_disbursement_requests_query)
		if requests.count > 0
			contracts = client.query(active_contract_query)
			disbursements = client.query(active_disbursements_query)

			requests.each_with_index do |r,index|
				puts "Fixing Disbusbursement Requests - #{index}"
				target_contract = contracts.select{|row| row['LMN_CuentaCTT__c'] == r['LMN_IdDesembolso__r']['LMN_ContratoDSB__r']['LMN_CuentaCTT__c'] }
				if target_contract.count > 0
					target_disbursement = disbursements.select{|row_d| row_d['LMN_ContratoDSB__c'] == target_contract.first['Id'] && row_d['LMN_Periodo__c'].to_i == r['LMN_IdDesembolso__r']['LMN_Periodo__c'].to_i}
					if target_disbursement.count > 0
						client.update('LMN_SolicitudDesembolsos__c', Id: r['Id'], LMN_IdDesembolso__c: target_disbursement.first['Id'],LMN_IdContrato__c: target_contract.first['Id'])
					end
				end
			end
		end
	end
	
	def migrate_questionnaires_main
		client = Restforce.new()

		join_questionnaires_sections = client.query("select LMN_IdGrupo__c, LMN_IdPrueba__c from LMN_PruebaGrupo__c")
		join_groups = join_questionnaires_sections.group_by { |d| d[:LMN_IdPrueba__c] }

		questionnaires_query = "select Id,LastModifiedDate, Name, LMN_PorcentajeGrupo__c,LMN_TiempoMaximoMinutos__c,LMN_Tipoprueba__c from LMN_Pruebas__c"
		questionnaires = client.query(questionnaires_query)

		companies = Company.kept
		companies.each do |company|
			questionnaires.each do |temp_questionnaire|
				aggregation_name = join_groups[temp_questionnaire.Id].nil? ? '[]' : join_groups[temp_questionnaire.Id].map{|q| q.LMN_IdGrupo__c}.sort.to_s
				new_questionnaire = Questionnaire.joins(:questionnaire_accumulation).where(questionnaire_accumulations: {name: aggregation_name},company_id: company.id).first
				if new_questionnaire.nil?
					new_questionnaire = Questionnaire.new()
				end
				if new_questionnaire.updated_at.nil? || new_questionnaire.updated_at < temp_questionnaire.LastModifiedDate
					new_questionnaire.name = properName(temp_questionnaire.Name)
					new_questionnaire.category = temp_questionnaire.LMN_Tipoprueba__c
					new_questionnaire.parent = nil
					new_questionnaire.max_score = temp_questionnaire.LMN_PorcentajeGrupo__c
					new_questionnaire.position = 0
					new_questionnaire.min_approval_score = 0
					new_questionnaire.time_limit = temp_questionnaire.LMN_TiempoMaximoMinutos__c
					new_questionnaire.weight = 100
					new_questionnaire.status = 'active'
					new_questionnaire.external_id = temp_questionnaire.Id
					new_questionnaire.migrated = true
					new_questionnaire.type_of_quesitonnaire = temp_questionnaire.LMN_Tipoprueba__c
					new_questionnaire.company_id = company.id
					new_questionnaire.save
				end
				target_accumulation = QuestionnaireAccumulation.joins(:questionnaire).where(questionnaires: {company_id: company.id}).find_by_external_id(temp_questionnaire.Id)
				if target_accumulation.nil?
					QuestionnaireAccumulation.create({questionnaire_id: new_questionnaire.id,name: aggregation_name,external_id: temp_questionnaire.Id})
				end
			end
		end
	end

	def migrate_questionnaire_sections
		client = Restforce.new()
		join_questionnaires_sections = client.query("select LMN_IdGrupo__c, LMN_IdPrueba__c from LMN_PruebaGrupo__c")
		total_sections = client.query("select Id,LastModifiedDate, Name,LMN_CalificacionMinima__c,LMN_CalificacionGrupoSubgrupo__c,RecordType.Name, LMN_Posicion__c from LMN_GruposSubgrupos__c where RecordType.Name='Grupo'")
		clean_sections = total_sections.map{|s| s}
		sections_ids = clean_sections.map{ |s| s.Id}

		join_questionnaires_sections.each_with_index do |join, index|

			target_questionnaires = Questionnaire.joins(:questionnaire_accumulation).where(questionnaire_accumulations: {external_id: join.LMN_IdPrueba__c})
			target_questionnaires.each do |target_questionnaire|
				mainSubgrups = Questionnaire.joins(:parent).where(parents_questionnaires: {id: target_questionnaire.id}).where(external_id: join.LMN_IdGrupo__c)
				if mainSubgrups.count == 0
					mainSubgrups = [Questionnaire.new()]
				end

				target_section = clean_sections[sections_ids.index(join.LMN_IdGrupo__c)]

				mainSubgrups.each do |mainSubgrup|
					if mainSubgrup.updated_at.nil? || mainSubgrup.updated_at < target_section.LastModifiedDate
						mainSubgrup.name = properName(target_section.Name)
						mainSubgrup.category = 'section'
						mainSubgrup.parent = target_questionnaire
						mainSubgrup.type_of_quesitonnaire = target_questionnaire.type_of_quesitonnaire
						mainSubgrup.company_id = target_questionnaire.company_id
						mainSubgrup.max_score = 100
						mainSubgrup.position = target_section.LMN_Posicion__c
						mainSubgrup.min_approval_score = target_section.LMN_CalificacionMinima__c.to_f * 10000 / target_section.LMN_CalificacionGrupoSubgrupo__c.to_f
						mainSubgrup.time_limit = target_questionnaire.time_limit
						mainSubgrup.weight = target_section.LMN_CalificacionGrupoSubgrupo__c
						mainSubgrup.status = 'active'
						mainSubgrup.external_id = target_section.Id
						mainSubgrup.migrated = true
						mainSubgrup.save
					end
				end
			end
		end
	end



	def migrate_questionnaire_subsections
		client = Restforce.new()
		total_subsections = client.query("select Id,LastModifiedDate, Name,LMN_CalificacionMinima__c,LMN_CalificacionGrupoSubgrupo__c,RecordType.Name,LMN_Posicion__c,LMN_IdGrupoSubgrupo__c from LMN_GruposSubgrupos__c where RecordType.Name='Subgrupo'")
		clean_subsections = total_subsections.map{|s| s}
		clean_subsections.each do |subGroup|
			mainSubgrups = Questionnaire.where(external_id: subGroup.LMN_IdGrupoSubgrupo__c)
			mainSubgrups.each do |mainSubgrup|
				newSubgroups = Questionnaire.joins(:parent).where(parents_questionnaires: {id: mainSubgrup.id}).where(external_id: subGroup.Id)
				if newSubgroups.count == 0
					newSubgroups = [Questionnaire.new()]
				end
				newSubgroups.each do |newSubgroup|
					if newSubgroup.updated_at.nil? || newSubgroup.updated_at < subGroup.LastModifiedDate
						newSubgroup.name = properName(subGroup.Name)
						newSubgroup.category = 'subsection'
						newSubgroup.parent = mainSubgrup
						newSubgroup.type_of_quesitonnaire = mainSubgrup.type_of_quesitonnaire
						newSubgroup.company_id = mainSubgrup.company_id
						newSubgroup.max_score = 100
						newSubgroup.position = subGroup.LMN_Posicion__c
						newSubgroup.min_approval_score = subGroup.LMN_CalificacionMinima__c.to_f * 10000 / subGroup.LMN_CalificacionGrupoSubgrupo__c.to_f
						newSubgroup.time_limit = mainSubgrup.time_limit
						newSubgroup.weight = subGroup.LMN_CalificacionGrupoSubgrupo__c
						newSubgroup.status = 'active'
						newSubgroup.external_id = subGroup.Id
						newSubgroup.migrated = true
						newSubgroup.save
					end
				end
			end
		end
	end

	def migrate_questionnaire_questions
		client = Restforce.new()
		sf_questions = client.query("select Id,LastModifiedDate,LMN_Pregunta__c,LMN_IdGrupoSubgrupo__c,LMN_IdPais__r.LMN_CodigoPais__c,LMN_TipoPrueba__c from LMN_BancosPreguntas__c")
		clean_questions = sf_questions.map{|q| q}
		clean_questions.each_with_index do |sf_question, qindex|

			target_subsections = Questionnaire.joins(:company,company: :country).where(external_id: sf_question.LMN_IdGrupoSubgrupo__c,type_of_quesitonnaire: sf_question.LMN_TipoPrueba__c,companies: {countries: {international_code: sf_question.LMN_IdPais__r.LMN_CodigoPais__c} })
			target_subsections.each do |target_subsection|
				newQuestions = Question.joins(:questionnaire).where(external_id: sf_question.Id,questionnaires: {id: target_subsection.id})
				if newQuestions.count == 0
					newQuestions = [Question.new()]
				end
				newQuestions.each do |newQuestion|
					if newQuestion.updated_at.nil? || newQuestion.updated_at < sf_question.LastModifiedDate
						newQuestion.question = sf_question.LMN_Pregunta__c
						newQuestion.position = qindex
						newQuestion.category = 'multiple_options'
						newQuestion.max_score = 100
						newQuestion.questionnaire = target_subsection
						newQuestion.external_id = sf_question.Id
						newQuestion.migrated = true
						newQuestion.save
					end
				end
			end
		end
	end

	def migrate_questionnaire_answers
		client = Restforce.new()
		sf_answers = client.query("select Id,LastModifiedDate,LMN_Valor__c,LMN_Posicion__c,LMN_CalificacioCuantitativa__c,LMN_BancoPreguntas__c from LMN_Opciones__c")
		clean_answers = sf_answers.map{|a| a}

		clean_answers.each do | sf_answer|

			newQuestions = Question.where(external_id: sf_answer.LMN_BancoPreguntas__c)
			newQuestions.each do |newQuestion|
				newAnswers = Answer.where(external_id: sf_answer.Id,question_id: newQuestion.id)
				if newAnswers.count == 0
					newAnswers = [Answer.new()]
				end
				newAnswers.each do |newAnswer|
					if newAnswer.updated_at.nil? || newAnswer.updated_at < sf_answer.LastModifiedDate
						newAnswer.answer = sf_answer.LMN_Valor__c
						newAnswer.position = sf_answer.LMN_Posicion__c
						newAnswer.score = sf_answer.LMN_CalificacioCuantitativa__c * 100
						newAnswer.question = newQuestion
						newAnswer.external_id = sf_answer.Id
						newAnswer.migrated = true
						newAnswer.save
					end
				end
			end
		end
	end

	def refresh_research some_input
		MigrationAsync.perform_async('refresh_research',nil)
		migrate_research_variables
		migrate_research_subvariables
		migrate_research_filters
		migrate_research_data
	end

	def migrate_research_variables
		client = Restforce.new()
		sf_variable = client.query("select Id,LastModifiedDate, Name, LMN_Acronimo__c, LMN_Tipo__c from LMN_Variable__c")
		clean_variables = sf_variable.map{|v| v}

		clean_variables.each do | target_variable|
			newVariable = ResearchVariable.find_by_external_id(target_variable.Id)
			if newVariable.nil?
				newVariable = ResearchVariable.new()
			end

			if newVariable.updated_at.nil? || newVariable.updated_at < target_variable.LastModifiedDate
				newVariable.name = target_variable.Name
				newVariable.type_of_variable = target_variable.LMN_Tipo__c
				newVariable.acronym = target_variable.LMN_Acronimo__c
				newVariable.external_id = target_variable.Id
				newVariable.save
			end
		end
	end


	def migrate_research_subvariables
		client = Restforce.new()
		sf_filters = client.query("select Id,LastModifiedDate, Name,LMN_Variable__c,LMN_Acronimo__c from LMN_Filtro__c")
		clean_filters = sf_filters.map{|f| f}
		clean_filters.each do |filter|
			parent = ResearchVariable.find_by_external_id(filter.LMN_Variable__c)

			newSubVariables = ResearchVariable.where(acronym: filter.LMN_Acronimo__c)
			if newSubVariables.count == 0
				newSubVariables = [ResearchVariable.new()]
			end
			newSubVariables.each do |newSubVariable|
				if newSubVariable.updated_at.nil? || newSubVariable.updated_at < filter.LastModifiedDate
					newSubVariable.name = filter.Name
					newSubVariable.type_of_variable = 'variable'
					newSubVariable.acronym = filter.LMN_Acronimo__c
					newSubVariable.external_id = filter.Id
					newSubVariable.parent_id = parent.id
					newSubVariable.save
				end
				target_accumulation = MigrationAccumulation.where(resource_type: 'ResearchVariable').find_by_external_id(filter.Id)
				if target_accumulation.nil?
					MigrationAccumulation.create(resource_id: newSubVariable.id, resource_type: 'ResearchVariable', external_id: filter.Id, name: filter.LMN_Acronimo__c )
				end
			end
		end
	end

	def migrate_research_filters
		client = Restforce.new()
		sf_filters = client.query("select Id,LastModifiedDate, LMN_Variable__c,LMN_Acronimo__c,LMN_Filtro__c,LMN_Orden__c,LMN_Nivel__c, LMN_PaisFLT__r.LMN_CodigoPais__c from LMN_Filtro__c")
		clean_filters = sf_filters.map{|f| f}

		clean_filters.each do |filter|
			target_variable = ResearchVariable.joins(:migration_accumulation).where(migration_accumulations:{ external_id: filter.Id}).first
			target_filter = ResearchVariable.find_by_external_id(filter.LMN_Filtro__c)
			target_country = Geography.find_by_value(filter.LMN_PaisFLT__r.LMN_CodigoPais__c)

			newFilter = ResearchFilter.find_by_external_id(filter.Id)
			if newFilter.nil?
				newFilter = ResearchFilter.new()
			end

			newFilter.variable_id = target_variable.id
			newFilter.filter_id = target_filter.id
			newFilter.order = filter.LMN_Orden__c
			newFilter.acronym = filter.LMN_Acronimo__c
			newFilter.country_id = target_country.id
			newFilter.level = filter.LMN_Nivel__c
			newFilter.external_id = filter.Id
			newFilter.save
		end
	end

	def migrate_research_data
		client = Restforce.new()
		sf_research_data = client.query("select Id,LastModifiedDate, LMN_Filtro__c,LMN_Hash__c,LMN_Valor__c,LMN_TipoDato__c from LMN_Investigacion__c")
		clean_research_data = sf_research_data.map{|f| f}
		clean_research_data.each do |data|
			target_variable = ResearchVariable.joins(:migration_accumulation).where(migration_accumulations:{ external_id: data.LMN_Filtro__c}).first
			newData = ResearchModelInfo.find_by_external_id(data.Id)
			if newData.nil?
				newData = ResearchModelInfo.new()
			end
			if newData.updated_at.nil? || newData.updated_at < data.LastModifiedDate
				newData.research_variable_id = target_variable.id
				newData.hash_text = data.LMN_Hash__c
				newData.value = data.LMN_Valor__c
				newData.info_format = data.LMN_TipoDato__c
				newData.external_id = data.Id
				newData.save
			end
		end
	end


	def lumni_import object, options = {}
		client = Restforce.new()
		general_description = client.describe(object)
		fields = []
		if options[:fields].nil?
			fields = general_description.fields.map{|a| a.name}
		else
			fields = options[:fields]
		end

		fields = fields.uniq.compact - ['']
		query_text = 'select ' + fields.join(', ') + ' from ' + object + (options[:conditional].nil? ? '' : ' ' + options[:conditional])
		puts 'this is the query: ' + query_text
		query_result = client.query(query_text)
		return query_result
	end

	def main_migration_method target_ids
		extra_checks
		t_id = target_ids.first
		target_record = Migration.find(t_id)
		target_record.update({ notes: nil})
		options = get_migration_options(target_record)

		if !target_record.function_text.nil? && target_record.function_text != ""
			target_action = target_record.function_text
	  		eval("#{target_action}(target_record.id,options)")
	  	else

			MigrationJob.create({migration_id: t_id , target_array: target_ids.to_s, status: 'active', target_record_number: nil, external_id: SecureRandom.hex})
		end
	end

	def restart_target_job target_id
			job = MigrationJob.find(target_id)
		    job.migration_tracking.delete_all
		    job.start_migration
	end

	def get_migration_options migration
	    options = eval(migration.options.to_s)
	    if options.nil?
	      options = {}
	    end
	    return options
	end


	def migration_import_and_process migration_job, additional_options = {}

		if additional_options[:migration_id].nil?
			target_migration = migration_job.migration
			target_status = 'regular'
		else
			target_migration = Migration.cached_find(additional_options[:migration_id])
			target_status = 'reference_fix'
		end
		options = get_migration_options(target_migration)

		rails_fields = target_migration.migration_field

		sf_fields = target_migration.migration_field.map{|m| m.sf_field} + ['Id','LastModifiedDate'].uniq.sort - [""]
		sf_fields += ['IsDeleted'] if target_migration.sf_object != 'User'
		sf_fields += options[:additional_fields].map{|v| v.gsub ' ',''} if !options[:additional_fields].nil?
		sf_fields = sf_fields.compact

		options[:fields] = sf_fields
		options[:conditional] = target_migration.where_field

		if !additional_options[:sf_id].nil?
			if options[:conditional].nil? || options[:conditional] == ''
				options[:conditional] = " where Id = '#{additional_options[:sf_id]}'"
			else
				options[:conditional] += " AND Id = '#{additional_options[:sf_id]}'"
			end
		end

		sf_record = lumni_import( target_migration.sf_object, options)

		clean_sf_records = cleaning_sf_batch( sf_record, sf_fields,options)


		if clean_sf_records.count > 0
			if additional_options[:sf_id].nil?
				migration_job.update(target_record_number: clean_sf_records.count)
			end
			MigrationsBackup.create({migration_id: target_migration.id, backup: clean_sf_records.to_s, user_id: target_migration.audits.last.user_id})


			clean_sf_records.in_groups_of(100, false) do |information_group|
				MigrationTracking.create({migration_job_id: migration_job.id, processed_records: 0, backup: information_group.compact.to_s,status: target_status})
			end
		end

	end



	def process_migration_group target_tracking_id
		sleep 10
		target_tracking = MigrationTracking.cached_find(target_tracking_id)
		target_job = target_tracking.migration_job
		if target_tracking.adjust_migration.nil?
			target_migration = target_job.migration
		else
			target_migration = Migration.cached_find(target_tracking.adjust_migration)
		end
		options = get_migration_options target_migration
		information_group = eval(target_tracking.backup)

		rails_fields = target_migration.migration_field


		cases_to_check = []

		information_group.each do |target_sf|
			target_migration.reload
			if target_migration.status == 'force_stop'
				target_migration.update({notes: 'It was forced stop'})
				exit!
			end

			external_id = target_sf['Id'] 
			external_id += '_' +target_migration.id.to_s if options[:external_migration_id]

			if options[:target_record].nil?
				target_record = eval(target_migration.rails_object).find_by_external_id(external_id)
				if target_record.nil?
					target_record = eval(target_migration.rails_object).new
				end
			else
				begin
					target_record = eval(options[:target_record])
				rescue Exception => e
					target_record = nil
					cases_to_check += ["#{external_id}: #{e.message}------- \n"]
				end
			end
			validation_time = target_record.updated_at.nil? ? true : (target_record.updated_at - 2.days) < target_sf['LastModifiedDate'].to_datetime
			if (!target_record.nil? && validation_time) || target_migration.status == 'force_migration'
#			if true
				target_record = assigning_values_from_sf( target_record, target_sf, target_migration,rails_fields,external_id,target_tracking_id: target_tracking_id)
			end

		end

		target_tracking.update(processed_records: information_group.count)

		if target_tracking.status == 'regular'
			target_migration.reload
			target_migration.update(status: 'done',notes: "#{target_migration.notes} -- #{cases_to_check.count} cases to check. #{cases_to_check}")
			target_job.reload
			if Migration.advance_level.uniq.count == 1
				target_array = eval(target_job.target_array)
				array_index = target_array.index(target_migration.id)
				if array_index < (target_array.count - 1)
					if target_array[array_index + 1] != target_migration.id
						MigrationJob.create({migration_id: target_array[array_index + 1] , 
							target_array: target_array.to_s, status: 'active', target_record_number: nil, external_id: target_job.external_id})
					end
				end
			end
		end

	end


	def assigning_values_from_sf target_record, target_sf, target_migration,rails_fields,external_id, options={}
		save_validation = true

		if true
#		if target_record.updated_at.nil? || target_record.updated_at < target_sf['LastModifiedDate'] || target_migration.status == 'force_migration'
			rails_fields.each do |field|
				case field.type_of_field
				when 'regular'
					target_record[field.model_field] = target_sf[field.sf_field]
				when 'function'
					target_record[field.model_field] = eval("#{field.function_text}(field.id,target_sf)")
				when 'references'
					if !target_sf[field.sf_field].nil?
						reference_record = eval(field.object_reference).find_by_external_id(target_sf[field.sf_field])
						if reference_record.nil?
							# if !options[:target_tracking_id].nil?

							# 	target_tracking = MigrationTracking.cached_find(options[:target_tracking_id])

							# 	probable_migrations = Migration.where(rails_object: field.object_reference, id: Migration.migration_order - [target_migration.id])
							# 	temp_migration_ids = Migration.migration_order - (Migration.migration_order - probable_migrations.ids) - [target_migration.id]

							# 	temp_migration_ids.each do |temp_id|
							# 		temp_migration = Migration.cached_find(temp_id)
							# 		migration_import_and_process target_tracking.migration_job, {migration_id: temp_migration.id,sf_id: target_sf[field.sf_field]}
							# 	end
							# end
							reference_record = eval(field.object_reference).find_by_external_id(target_sf[field.sf_field])
							if reference_record.nil?
								target_migration.update({notes: "#{target_migration.notes} -- Reference not found -- target_tracking_id:#{options[:target_tracking_id]} ; SF_ID: #{target_sf[field.sf_field]}"})
								# exit!
							end
						end
					else
						reference_record = nil
					end

					target_record[field.model_field] = reference_record.id if !reference_record.nil?
				when 'fixed_value'
					target_record[field.model_field] = field.fixed_value
				end
			end

			if !options[:save_validation].nil?
				save_validation = eval(options[:save_validation])
			end

			target_record.external_id = external_id
			target_record.migrated  = true


			# For User records
			if ["Student","Team","User"].include?(target_record.class.to_s)

				target_record.first_name = 'example_name' if target_record.first_name.nil?
				target_record.last_name = 'example_lastname' if target_record.last_name.nil?

				original_record_with_email = User.find_by_email(target_record.email)
				if target_record.nil? && !original_record_with_email.nil?
					target_record.email = target_record.email.gsub '@', "+#{target_record.external_id}@"
				end



				if target_record.id.nil?
					target_record.password = (0...8).map { (65 + rand(26)).chr }.join
				end
				target_record.skip_confirmation!
				target_record.skip_confirmation_notification!
				target_record.skip_reconfirmation!
			end

			if save_validation
				
				unless target_record.save
					target_migration.update({notes: "#{target_migration.notes}\n Problems saving: with #{target_sf} ======= #{target_record.attributes}\n\n",status: 'error'})
				end
			end
		end
		return target_record
	end	

	def cleaning_sf_batch sf_record, sf_fields,options={}
		clean_sf_records = []
		sf_record.each do |row|
			temp_row = {}
			sf_fields.each do |f|
				location = "['#{f.split('.').join("']['")}']"
				begin
					temp_row = temp_row.merge(f => eval("row#{location}"))
				rescue Exception => e
					nil			
				end
			end
			clean_sf_records += [temp_row]
		end
		return clean_sf_records
	end





	def legal_document_contract_migration migration_id,options={}
		target_migration = Migration.cached_find(migration_id)
		rails_fields = target_migration.migration_field


		sf_fields = target_migration.migration_field.map{|m| m.sf_field} + ['Name','Id','LastModifiedDate','IsDeleted',
			'LMN_PlantillaContratoMenor__c','LMN_PlantillaContratoIIMenor__c','LMN_AnexosContratoMenor__c',
			'LMN_PlantillaContratoMayor__c','LMN_PlantillaContratoIIMayor__c','LMN_AnexosContratoMayor__c',
			'LMN_PlanillaOtroSi__c','LMN_PlanillaOtroSiMenores__c','LMN_PoliticasPrivacidad__c','LMN_TerminosCondiciones__c']
		sf_record = lumni_import( target_migration.sf_object, fields: sf_fields)



		clean_sf_records = cleaning_sf_batch( sf_record, sf_fields,options)
		MigrationsBackup.create({migration_id: migration_id, backup: clean_sf_records.to_s, user_id: target_migration.audits.last.user_id})


		clean_sf_records.each do |target_sf|
			if Migration.find(migration_id).status == 'force_stop'
				Migration.find(migration_id).update({notes: 'It was forced stop'})
				exit!
			end

			external_id = target_sf['Id'] + '_' +target_migration.id.to_s


			target_record = eval(target_migration.rails_object).find_by_external_id(external_id)
			if target_record.nil?
				target_record = eval(target_migration.rails_object).new
			end
			# begin
				target_record = assigning_values_from_sf( target_record, target_sf, target_migration,rails_fields,external_id, save_validation: 'target_record.body.length > 40')
		  # rescue Exception => e
		  # 	Migration.find(migration_id).update({status: 'error', notes: "#{e.message}", result: "#{e.backtrace.inspect}"})
		  # 	exit!
		  # end

		end

		target_migration.update({status: 'done',notes:''})
	end




# Academic Status
["Egresado", nil, "Retirado", "Estudiando", "Expulsado", "Aplazado"]

# Payment Status
["Pagos al día", "Sin obligación de pago", "Pagos atrasados", "Default"]

# Work Status
["No empleado", "Empleado", "Período de gracia"]

# General Status
["Terminó pagos", "Default", "Activo", "Cesión de contratos", "Inactivo", "Salió del fondo"]

["LMN_EstadoAcademico__c", "LMN_EstadoPagos__c", "LMN_EstadoLaboral__c", "LMN_EstadoGeneral__c"]

	def duplicate_migration

		include FormInfoHelper
		origin = 191
		new_name = "Fund Bank Account (fee partial payment)"

		original_migration = Migration.find(origin)
		new_migration = original_migration.dup
		new_migration.name = new_name
		new_migration.status = 'done'
		new_migration.notes = ""
		new_migration.save

		target_fields = MigrationField.where(migration_id: new_migration.id)

		target_fields.each do |field|
			original_field = original_migration.migration_field.find_by_model_field(field.model_field)
			target_info = original_field.attributes
			delete_keys = system_variables + ['migration_id']
			delete_keys.map{|val| target_info.delete(val)}
			field.update_attributes(target_info)
		end



	end





	def create_backup_migration  object_id,options={}
		object = BackupObject.find(object_id)
		begin
			target_data = lumni_import object.name
			target_fields = BackupField.where(backup_object_id: object.id).to_a
		rescue Exception => e
			target_data = nil
			object.update_attributes({status: 'query_error',notes: "#{object.external_id}: #{e.message} \n"})
		end

		unless target_data.nil?
			current_ids = BackupInfo.joins(:backup_field, backup_field: :backup_object).where(backup_fields: {backup_object_id: object_id,name: "Id"}).pluck(:external_id).uniq
			target_data.each do |record|
				if current_ids.index(record["Id"]).nil?
					target_fields.each do |field|
						target_record = BackupInfo.where(external_id: record["Id"], backup_field_id: field.id).first
						if target_record.nil?
							target_record = BackupInfo.create(backup_field_id: field.id,value: record[field.name],external_id: record["Id"])
						end
					end
				end
			end
		end
	end

	def create_sf_structure migration_id,options={}
		client = Restforce.new()
		objects = client.describe

		objects.map{|o| o.to_h}.each_with_index do |object,index|
			puts "#{index} of #{objects.size}"
			target_object = BackupObject.find_by_name(object["name"])
			if target_object.nil?
				target_object = BackupObject.create({name: object["name"],label: object["label"],custom: object["custom"],status: 'created'})
			end

			begin
				object_description = client.describe object["name"]
				object_description = object_description.to_h
			rescue Exception => e
				object_description = nil
				object.update_attributes({status: 'error_getting_fields',notes: "#{external_id}: #{e.message} \n"})
			end
			unless object_description.nil?
				object_description["fields"].each do |field|
					target_field = BackupField.where(backup_object_id: target_object.id, name: field["name"]).first
					if target_field.nil?
						target_field = BackupField.create({name: field["name"],label: field["label"],
							calculated: field["calculated"],field_case: field["type"],status: 'created',
							backup_object_id: target_object.id})
					end

					if !field["picklistValues"].nil? && field["picklistValues"].size > 0
						field["picklistValues"].each do |picklist|
							target_picklist = BackupPicklist.where(backup_field_id: target_field.id, value: picklist["value"]).first
							if target_picklist.nil?
								target_picklist = BackupPicklist.create({active: picklist["active"],default_value: picklist["default_value"],
									label: picklist["label"],value: picklist["value"],backup_field_id: target_field.id})
							end
						end
					end
				end
			end
		end
	end

	def split_backup_jobs object_id,options={}
		object = BackupObject.cached_find(object_id)
		client = Restforce.new()
		begin
			object_size = client.query("SELECT CreatedDate FROM #{object.name} ORDER BY CreatedDate")
			object_size = object_size.map{|o| o["CreatedDate"]}.uniq

			object_size.each_slice(5000).each do |batch|
				MigrationAsync.perform_async('create_backup_migration',"#{object.id};#{batch.first};#{batch.last}")
			end
		rescue
			MigrationAsync.perform_async('create_backup_migration',"#{object.id};#{'special_case'};#{'special_case'}")
		end


	end



	def statistics_from_sf target_ids
		# client = Restforce.new()
		# objects_detail = client.describe
		# force_migrate = ['Account','Contact','Opportunity']
		# exeption_fields = ["IsDeleted", "SystemModstamp", "LastModifiedById", "LastModifiedDate", "CreatedById", "CreatedDate", "Id"]
		# objects_detail.each do |object|
		# 	target_object = CheckObject.find_by_name(object.name)
		# 	if target_object.nil?
		# 		target_object = CheckObject.new
		# 	end
		# 	target_object.name = object.name
		# 	target_object.label = object.label
		# 	begin

		# 		target_object.custom = object.custom
		# 		target_object.migrate = (object.custom || !force_migrate.index(object.name).nil?) if target_object.id.nil?
		# 		target_object.rows = client.query("SELECT COUNT(Id) FROM #{object.name}").first.expr0
		# 	rescue Exception => e
		# 		target_object.notes = "Object Migration Error: \n \n #{e.message} \n"
		# 	end

		# 	if target_object.save
		# 		fields_description = client.describe(object.name)

		# 		fields_description.fields.each do |field|
		# 			target_field = target_object.check_field.find_by_name(field.name)
		# 			if target_field.nil?
		# 				target_field = CheckField.new
		# 			end

		# 			target_field.check_object_id = target_object.id
		# 			target_field.name = field.name
		# 			target_field.label = field.label
		# 			target_field.field_case = field.type
		# 			begin
		# 				target_field.calculated = field.calculated
		# 			rescue Exception => e
		# 				target_field.notes = "Field Migration Error: \n \n #{e.message} \n"
		# 			end
		# 			begin
		# 				target_field.nil_percentage = client.query("SELECT COUNT(Id) FROM #{object.name} where #{field.name} = NULL ").first.expr0
		# 			rescue Exception => e
		# 				target_field.notes = "Field Migration Error: \n \n #{e.message} \n"
		# 			end

		# 			migrated = false
		# 			target_migration = Migration.where(sf_object: object.name)
		# 			if target_migration.count > 0
		# 				migrated = MigrationField.where(sf_field: field.name, migration_id: target_migration.ids).count > 0
		# 			end

		# 			if migrated
		# 				target_field.status = 'migrated'
		# 			else
		# 				if !exeption_fields.index(field.name).nil?
		# 					target_field.status = 'system'
		# 				elsif target_field.calculated
		# 					target_field.status = 'function'
		# 				elsif target_object.migrate
		# 					target_field.status = 'pending'
		# 				else
		# 					target_field.status = 'not_migrate'
		# 				end
		# 			end
		# 			if target_field.save
		# 				begin
		# 					content_detail = client.query("SELECT #{field.name}, COUNT(Id) FROM #{object.name} GROUP BY #{field.name} ORDER BY COUNT(Id) DESC LIMIT 10")
		# 					content_detail.each do |detail|
		# 						target_detail = target_field.check_mode.find_by_label(detail.Name)
		# 						if target_detail.nil?
		# 							target_detail = CheckMode.new
		# 						end
		# 						target_detail.check_field_id = target_field.id
		# 						target_detail.label = detail.Name
		# 						target_detail.frequency = detail.expr0
		# 						target_detail.save
		# 					end
		# 				rescue
		# 				end
		# 			end
		# 		end
		# 	end
		# end
	end








end