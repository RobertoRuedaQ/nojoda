module OriginationsHelper
	include LumniApplicationForms
	def createEligibilityCriteria funding_opportunity_id=nil, legal_id = nil,options={}
		@options = options
		@funding_opportunity = FundingOpportunity.cached_find(funding_opportunity_id) if !funding_opportunity_id.nil?

		if legal_id.nil?
			@legal_document = LegalDocument.new()
		else
			@legal_document = LegalDocument.cached_find(legal_id)
		end
		@legal_match = LegalMatch.new()

		render 'legal_matches/partial/eligibility_criteria'
	end

	def origination_elements user_id = nil, options={}
		origination_elements = []
		if options[:isa_creation]
			target_company = current_company
			origination_elements = ['account_creation','verification_process','eligibility_criteria','apply']

			if !target_company.credit_check_disclosure_id.nil?
				origination_elements += ['credit_check']
			end
			# if !target_company.interview.nil?
			# 	origination_elements += ['interview']
			# end
			if !target_company.automatic_proposal_display
				origination_elements += ['information_review']
			end
		end
		origination_elements += ['proposal_selection','contract','finish']

		return origination_elements
	end

	def origination_target_contract_id target_user
		target_isa = target_user.active_isa.last
		current_application = target_user.current_application
		funding_opportunity = current_application.funding_opportunity unless current_application.nil?

		if current_application.nil? && target_isa.present?
			if target_isa.funding_option.legal_match.any?
				target_contract_id = target_isa.funding_option.legal_match.first.legal_document_id
			else
				target_contract_id = contract_by_age target_user, target_isa.funding_opportunity, 'contract'
			end
		## add the contract depending the age of the student
		elsif (current_application.present? && funding_opportunity.present? && current_application.resource_type != 'Isa' && current_application.present?)
			target_contract_id = contract_by_age target_user,funding_opportunity, 'contract'
		##when the resource_type is ISA it means is a ammendment of contract
		elsif current_application.present? && current_application.resource_type == 'Isa'
			if current_application.typology == 'blackrock'
				target_contract_id = blackrock_ammendment(current_application)
			else
				target_contract_id = contract_by_age target_user,current_application.original_application.funding_opportunity, 'amendment'
			end
		end
		return target_contract_id
	end

	def origination_promissory_note_id(target_user)
		current_application = target_user.current_application
		return unless current_application
		funding_opportunity = current_application.funding_opportunity unless current_application.nil?
		return unless funding_opportunity
		if funding_opportunity.include_promissory_note
			target_promissory_note_id = contract_by_age target_user,funding_opportunity, 'promissory_note'
		end
		return target_promissory_note_id
	end

	def blackrock_ammendment(current_application)
		current_application.original_application.funding_opportunity.blackrock_ammendment_id
	end

	def contract_by_age target_user,funding_opportunity, isa_case
		case isa_case
		when 'contract'
			if target_user.age.nil?
				target_contract = funding_opportunity.contract_adult_id
			else
				if target_user.adult?(current_company.country)
					target_contract = funding_opportunity.contract_adult_id
				else
					target_contract = funding_opportunity.contract_young_id
				end
			end
		when 'amendment'
			if target_user.age.nil?
				target_contract = funding_opportunity.amendment_adult_id
			else
				if target_user.adult?(current_company.country)
					target_contract = funding_opportunity.amendment_adult_id
				else
					target_contract =  funding_opportunity.amendment_young_id
				end
			end
		when 'promissory_note'
			if target_user.age.nil?
				target_contract = funding_opportunity.adult_promissory_note_id
			else
				if target_user.adult?(current_company.country)
					target_contract = funding_opportunity.adult_promissory_note_id
				else
					target_contract =  funding_opportunity.young_promissory_note_id
				end
			end
		end
		
		return target_contract
	end

	def originationStep user, options = {}
		target_user = user
		origination_element = origination_elements(nil, options)

		target_contract = origination_target_contract_id( target_user)
		target_promissory_note = origination_promissory_note_id(target_user)
		step = 1
		if target_user.eligibility_criteria_step && options[:isa_creation]
			puts 'paso1'
			step = origination_element.index('eligibility_criteria')
		elsif target_user.filling_application_step && options[:isa_creation]
			puts 'paso2'
			step = origination_element.index('apply')
		elsif target_user.credit_check_step( current_company, !origination_element.index('credit_check').nil?)  && options[:isa_creation]
			puts 'paso3'
			step = origination_element.index('credit_check')
		# elsif !target_user.pending_interview?
		# 	puts 'paso5'
		# 	step = origination_element.index('interview')
		elsif target_user.current_application.present? && !target_user.current_application.show_financial_proposals && target_user.contract_step(current_company, target_contract) && !current_company.automatic_proposal_display  && options[:isa_creation]
			puts 'paso6'
			step = origination_element.index('information_review')
		elsif target_user.current_application.present? && target_user.current_application.modeling_match.nil? && target_user.contract_step(current_company, target_contract)
			puts 'paso7'
			step = origination_element.index('proposal_selection')
		elsif target_user.contract_step(current_company, target_contract, target_promissory_note)
			puts 'paso8'
			step = origination_element.index('contract')
		elsif target_user.current_application.present? && !target_user.current_application.modeling_match.nil?
			puts 'paso9'
			step = origination_element.index('finish') 
		end
		return step
	end

	def create_hidden_values_application application_id
		hidden_fields = {}
		hidden_fields[:application] = {model:'application',field: 'id', value: application_id}
		return hidden_fields
	end

	def create_origination_icon action
		target_icon = 'ion ion-ios-journal'
		case action
		when 'account_creation'
			target_icon = 'ion ion-md-play-circle'
		when 'verification_process'
			target_icon = 'fas fa-user-check'
		when 'eligibility_criteria'
			target_icon = 'fas fa-handshake'
		when 'apply'
			target_icon = 'fas fa-database'
		when 'credit_check'
			target_icon = 'ion oi oi-credit-card'
		when 'contract'
			target_icon = 'oi oi-document'
		when 'finish'
			target_icon = 'ion ion-md-checkmark-circle-outline'
		when 'interview'
			target_icon = 'ion ion-md-people'
		when 'information_review'
			target_icon = 'ion ion-md-clipboard'
		when 'proposal_selection'
			target_icon = 'ion ion-md-cash'
		end
		return target_icon
	end



end
