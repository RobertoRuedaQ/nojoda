module LumniModeling
	include LumniDisbursement
	
	def store_modeling_info modeling_info, valuation_history_id=nil
		if modeling_info.present? && modeling_info.is_a?(Hash)
			ModelingFlow.storing_modeling_info(modeling_info,valuation_history_id)
		end
	end

	def add_disbursement_modeling isa, disbursement_info, typology = 0
		original_application = isa.funding_option.right_application
		application = original_application.dup
		application.typology = typology # default = 0
		application.application_case = 'add_disbursement_modeling'
		application.original_application_id = original_application.original_application.present? ? original_application.original_application_id : original_application.id
		application.resource_type = 'Isa'
		application.resource_id = isa.id
		application.status = 'submitted'
		application.external_id = nil
		application.show_financial_proposals = nil
		application.save
		options = { 
			funding_option_id: isa.funding_option.id,
			disbursement_info: disbursement_info,
			application_id: original_application.id,
			original_option_id: isa.funding_option.id
		}
		modeling_students(application, options)
	end

	def assign_modeling_variables user, options={}
		if options[:program_id].present?
			program = StudentAcademicInformation.find(options[:program_id])
		else
			program = user.application.find_by(status: ['submitted','approved']).funded_major.potential_not_approved_version
		end

		institution = program.institution
		modeling_variables_hash = program.modeling_clusters

		filters = ResearchFilter.includes(:filter, :variable).joins(:country).where(geographies: {value: modeling_variables_hash['country_code']}).order(:level,:order).to_a
		levels = filters.group_by{|f| f.level}

		hash_of_keys = {}
		levels.each do |level_number, level|
			variables = level.group_by{|l| l.variable_id}
			variables.each do |key,variable|
				hash_of_keys[key] = {} if hash_of_keys[key].nil?
				query_array = [modeling_variables_hash['country_code']]
				variable.each do |filter|
					acronym = filter.filter.acronym
					if acronym == 'CIN'
						query_array += ["#{acronym}#{institution.code}"]
					else
						query_array += ["#{acronym}#{modeling_variables_hash[acronym]}"]
					end
				end
				hash_of_keys[key][level_number] = (query_array + [level_number]).join('_')
			end
		end

		target_keys = hash_of_keys.values.map(&:values).flatten
		temp_options = ResearchModelInfo.includes(:research_variable).where(hash_text: target_keys,active: true).to_a

		variable_options = temp_options.group_by{|v| v.research_variable_id}

		variable_options.each do |variable_id, record_info|
			hash_of_keys[variable_id].each do |level, key|
				record = record_info.select{|r| r.hash_text == key}.first
				if !record.nil?
#					modeling_variable.first.research_model_info.research_variable
					new_variable = ModelingVariable.joins(research_model_info: :research_variable).where(user_id: user.id).where(research_model_infos: {research_variables: {acronym: record.research_variable.acronym}}).first
					if new_variable.nil?
						ModelingVariable.create({user_id: user.id, research_model_info_id: record.id})
					else
						if new_variable.research_model_info_id != record.id
							new_variable.update(research_model_info_id: record.id)
						end
					end
					break
				end
			end
		end
	end

	def request_r_modeling target_params,target_action,target_url
		#Actions: ['get_sample_data','post_modeling']
	    response = RestClient::Request.execute(method: :post, url: "#{target_url}/#{target_action}",
	                                            :payload => target_params.to_json,
	                                            headers: {:content_type => :json, :accept => :json },
	                                            :verify_ssl => true, timeout: 3000 )
	    response.force_encoding("UTF-8")
	    result = JSON.parse(response.body)

	    return result
	end


	def modeling_students application, options={}
		if ['FundingOpportunity','Isa'].include?(application.resource_type)
			modeling = application.funding_opportunity.modeling
			exception_ids = application.funding_option.joins(:isa).ids

			ModelingFlowFee.joins(modeling_flow_detail: [modeling_flow: :funding_option]).where.not('funding_options.id IN (?)',exception_ids).where('funding_options.application_id = ?',application.id).delete_all
			ModelingFlowExtra.joins(modeling_flow_detail: [modeling_flow: :funding_option]).where.not('funding_options.id IN (?)',exception_ids).where('funding_options.application_id = ?',application.id).delete_all
			ModelingFlowDetail.joins(modeling_flow: :funding_option).where.not('funding_options.id IN (?)',exception_ids).where('funding_options.application_id = ?',application.id).delete_all
			ModelingFlowSummary.joins(modeling_flow: :funding_option).where.not('funding_options.id IN (?)',exception_ids).where('funding_options.application_id = ?',application.id).delete_all
			ModelingFlow.joins(:funding_option).where.not('funding_options.id IN (?)',exception_ids).where('funding_options.application_id = ?',application.id).delete_all
			

			application.funding_option.where.not(id: exception_ids).destroy_all

			application.invalid_funding_option.destroy_all

			if application.application_case == 'add_disbursement_modeling'
				program_to_fund = Application.find(options[:application_id]).program_to_fund.potential_not_approved_version
			else
				program_to_fund = application.program_to_fund.potential_not_approved_version
			end

			options[:program_id] = program_to_fund.id

			if !program_to_fund.nil?
				case modeling.modeling_case
				when 'fixed_conditions'
					modeling.modeling_fixed_condition.each do |financial_option|
						create_fixed_conditions financial_option, application, modeling,program_to_fund, options
					end
				when 'modeling_with_r'
					if application.application_case != 'add_disbursement_modeling'
						assign_modeling_variables application.user, options
					end
					modeling.modeling_fixed_condition.each do |financial_option|
						create_fixed_conditions financial_option, application, modeling,program_to_fund, options
					end
					application.reload

					if application.typology_special_scenario?
						application.invalid_funding_option.first.update(model_status: 'done')
					else
						application.invalid_funding_option.each do |funding_option|
							if Rails.env.production?
								funding_option.async_model_with_r
							else
								funding_option.model_with_r
							end
						end
					end
				when 'scholarship'
					create_scholarship_conditions(application, modeling, options={})
				end

			end
		end
	end

	def create_fixed_conditions financial_option, application, modeling, program, options={}

		case modeling.modeling_case
		when 'fixed_conditions'
			modeling_status = 'done'
		when 'modeling_with_r'
			modeling_status = 'pending'
		else
			modeling_status = 'not_determined'
		end

		
		temp_funding =	if application.typology_special_scenario?
											f_o = FundingOption.find(options[:funding_option_id])
											f_o.id = nil
											f_o.created_at = nil
											f_o.updated_at = nil
											f_o.model_status = modeling_status
											f_o.application_id = application.id
											f_o.visible_to_student = financial_option.modeling.visible_to_student
											FundingOption.create(f_o.attributes)
										else
											FundingOption.create({ 	application_id: application.id,
												percentage_student: financial_option.student_percentage,
												percentage_graduated: financial_option.graduated_percentage,
												isa_term: financial_option.term,
												target: financial_option.modeling.target_case,
												visible_to_student: financial_option.modeling.visible_to_student,
												offer_due_date: application.offer_due_date,
												modeling_fixed_condition_id: financial_option.id,
												model_status: modeling_status,
												original_option_id: options[:original_option_id]
											})
										end

		# Regular config add
		regular_config_list = ['nominal_payment','threshold','unemployment_months','grace_period']

		case application.application_case
		when 'origination'
			regular_config_list.each do |target_config|
				if !financial_option.send(target_config).nil?
					FundingOptionConfig.create({ 	funding_option_id: temp_funding.id,
													name: target_config,
													value: financial_option.send(target_config)
												})
				end
			end

			# Special config cases
			if !financial_option.cap_type.nil? && !financial_option.cap_value.nil?
				FundingOptionConfig.create({ 	funding_option_id: temp_funding.id,
												name: financial_option.cap_type,
												value: financial_option.cap_value
											})
			end
			
			#crea los elementos identificadores cuando tasa dinámica
			if application.funding_opportunity.dynamic_rate_cap
				country_name = application.user.company.country.name
				FundingOptionConfig.create({ 	
					funding_option_id: temp_funding.id,
					name: 'dynamic_rate_cap',
					other_value: 'true'
				})

				FundingOptionConfig.create({ 	
					funding_option_id: temp_funding.id,
					name: 'country',
					other_value: country_name
				})
			end

			# Disbursements
			if !modeling.custom_disbursements

				periodicity = program.disbursements_periodicity
				inicial_date = program.first_disbursement_date
				number_disbursements = program.number_of_disbursements_requiered
				inicial_value = program.disbursement_value
				funding_disbursement = application.funding_opportunity.funding_disbursement
				living_expenses_check = program.living_expenses_check


				disbursements = disbursement_hash( periodicity, inicial_date, number_disbursements, inicial_value,living_expenses_check,funding_disbursement)
				target_status = funding_disbursement.automatic_activation ? 'active' : 'generated'

				disbursements.values.each_with_index do |disbursement,index|
					Disbursement.create({ 	funding_option_id: temp_funding.id,
											currency: application.company.cached_currency,
											disbursement_case: disbursement[:disbursement_case],
											student_value: disbursement[:student_value],
											company_value: disbursement[:student_value],
											forcasted_date: disbursement[:forcasted_date],
											disbursement_number: index + 1,
											status: target_status,
											application_id: application.id,
											student_academic_information_id: program.id
										})
				end
			else

				funding_disbursement = application.funding_opportunity.funding_disbursement
				disbursements = disbursement_custom_hash(modeling, application.user_id, application.resource_id)
				target_status = funding_disbursement.automatic_activation ? 'active' : 'generated'

				disbursements.values.each_with_index do |disbursement,index|
					Disbursement.create({ 	funding_option_id: temp_funding.id,
											currency: disbursement[:currency],
											disbursement_case: disbursement[:disbursement_case],
											student_value: disbursement[:student_value],
											company_value: disbursement[:company_value],
											forcasted_date: disbursement[:forcasted_date],
											disbursement_number: index,
											status: target_status,
											application_id: application.id,
											student_academic_information_id: program.id
										})
				end			
			end
		when 'add_disbursement_modeling'
			original_funding_option = FundingOption.find(options[:funding_option_id])
			original_funding_option.funding_option_config.each do |f|
				temp_object = f.dup
				temp_object.funding_option_id = temp_funding.id
				temp_object.save
			end

			original_funding_option.active_disbursements.each do |d|
				FundingOptionDisbursement.find_or_create_by(disbursement_id: d.id, funding_option_id: temp_funding.id, evaluation_value: d.disbursed)
			end

			options[:disbursement_info].each do |di|
				di[:target_status] = 'active' if di[:target_status].nil?
				disbursement_number = temp_funding.disbursement.where(disbursement_case: di[:disbursement_case]).maximum(:disbursement_number).to_i + 1
				Disbursement.create({ 	
					funding_option_id: temp_funding.id,
					currency: di[:currency],
					disbursement_case: di[:disbursement_case],
					student_value: di[:student_value],
					company_value: di[:company_value],
					forcasted_date: di[:forcasted_date],
					disbursement_number: disbursement_number,
					status: di[:target_status],
					application_id: options[:application_id],
					student_academic_information_id: original_funding_option.right_application.funded_major.id
				})
			end
		end
		temp_funding.save
  end
  
  def create_scholarship_conditions application, modeling
    #declara el programa a financiar
    program = application.funded_major

    #se crea el modeling case en done para el caso de beca
    case modeling.modeling_case
    when 'scholarship'
      modeling_status = 'done'
    when 'modeling_with_r'
      modeling_status = 'pending'
    end
    #se crean las opciones de financiacion
    temp_funding = FundingOption.create({ 	
                        application_id: application.id,
                        percentage_student: 0,
                        percentage_graduated: 0,
                        isa_term: 0,
                        target: 'scholarship',
                        visible_to_student: true,
                        offer_due_date: application.offer_due_date,
                        modeling_fixed_condition_id: modeling.modeling_fixed_condition.first.id,
                        model_status: modeling_status
                      })

    # Regular config add
    regular_config_list = ['nominal_payment','threshold','unemployment_months','grace_period']

    case application.application_case
    when 'origination'
      #crea la configuracion de la opcion de financiacion
      regular_config_list.each do |target_config|
      FundingOptionConfig.create({ 	
                      funding_option_id: temp_funding.id,
                      name: target_config,
                      value: 0
                    })
      end

			#crea los elementos identificadores cuando tasa dinámica
			if application.funding_opportunity.dynamic_rate_cap
				country_name = application.user.company.country.name
				FundingOptionConfig.create({ 	
					funding_option_id: temp_funding.id,
					name: 'dynamic_rate_cap',
					other_value: 'true'
				})

				FundingOptionConfig.create({ 	
					funding_option_id: temp_funding.id,
					name: 'country',
					other_value: country_name
				})
			end
			
      # crea el desembolso
      if !modeling.custom_disbursements
        periodicity = program.disbursements_periodicity
        inicial_date = program.first_disbursement_date
        number_disbursements = program.number_of_disbursements_requiered
        inicial_value = program.disbursement_value
        funding_disbursement = application.funding_opportunity.funding_disbursement
        living_expenses_check = program.living_expenses_check


        disbursements = disbursement_hash( periodicity, inicial_date, number_disbursements, inicial_value,living_expenses_check,funding_disbursement)
        target_status = funding_disbursement.automatic_activation ? 'active' : 'generated'

        disbursements.values.each_with_index do |disbursement,index|
          Disbursement.create({ funding_option_id: temp_funding.id,
                      currency: application.company.cached_currency,
                      disbursement_case: disbursement[:disbursement_case],
                      student_value: disbursement[:student_value],
                      company_value: disbursement[:student_value],
                      forcasted_date: disbursement[:forcasted_date],
                      disbursement_number: index + 1,
                      status: target_status,
                      application_id: application.id,
                      student_academic_information_id: program.id
                    })
        end
      else

        funding_disbursement = application.funding_opportunity.funding_disbursement
        disbursements = disbursement_custom_hash(modeling, application.user_id, application.resource_id)
        target_status = funding_disbursement.automatic_activation ? 'active' : 'generated'

        disbursements.values.each_with_index do |disbursement,index|
          Disbursement.create({ 	funding_option_id: temp_funding.id,
                      currency: disbursement[:currency],
                      disbursement_case: disbursement[:disbursement_case],
                      student_value: disbursement[:student_value],
                      company_value: disbursement[:company_value],
                      forcasted_date: disbursement[:forcasted_date],
                      disbursement_number: index,
                      status: target_status,
                      application_id: application.id,
                      student_academic_information_id: program.id
                    })
        end			
      end
    end
  end

end
