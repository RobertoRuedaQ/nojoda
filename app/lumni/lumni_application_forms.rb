module LumniApplicationForms
	include FormbuilderHelper


	def applicationFormConciliationInformation section, student, application, options={}
		application.resource
	end


	def applicationFormCancellationRequest section, student, application, options={}
		application.resource
	end

	def applicationFormCovidEmergency section, student, application, options={}
		result = CovidEmergency.pending_to_review(student.id)
		if result.nil?
			if CovidEmergency.active_action_by_user(student.id).count > 0
				result = CovidEmergency.active_action_by_user(student.id).first
			end
		end
		return result


	end

	def applicationFormSocialWork section, student, application, options={}
		result = SocialWork.find_by(application_id: application.id, user_id: student.id)
		if result.nil?
			result = SocialWork.create({application_id: application.id,user_id: student.id})
		end
		return result
	end

	def applicationFormMentoryEmpleabilityInvitation section, student, application, options={}
		result = MentoryEmpleabilityInvitation.find_by(user_id: student.id)
		if result.nil?
			result = MentoryEmpleabilityInvitation.create({user_id: student.id})
		end
		return result
	end

	def applicationFormBlackRockData section, student, application, options={}
		result = BlackRockData.find_by(user_id: student.id)
		if result.nil?
			result = BlackRockData.create({user_id: student.id})
		end
		return result
	end

	def applicationFormUniversityGrade section, student, application, options={}
    
  
  	funded_academic_information = student.funded_academic_information
		case application.resource_type
		when "AcademicRequest"
			result = UniversityGrade.where(application_id: application.id).last
      if result.nil?
        result = UniversityGrade.create(student_academic_information_id: funded_academic_information.id, application_id: application.id)
      end
      return result
		else
			unless application.resource.try(:funding_option).nil? || application.resource.application.resource.funding_option.disbursement.minimum(:forcasted_date) == application.resource.forcasted_date
				result = UniversityGrade.where(disbursement_id: application.resource_id,student_academic_information_id: funded_academic_information.id).last
				if result.nil?
					result = UniversityGrade.create(disbursement_id: application.resource_id,student_academic_information_id: funded_academic_information.id, application_id: application.id)
				end
				return result
			else 
				ApplicationSectionTrack.create({application_id: application.id, origination_section_id: section.id})
			end
			return result
		end
	end

	def applicationFormUniversityCourseGrade section, student, application, options={}
		result = nil
		university_grade = applicationFormUniversityGrade section, student, application
		if (university_grade.present? && (university_grade.number_of_courses_taken.present?) || options[:number].present?)
			target_courses = (1..(options[:number].nil? ? university_grade.number_of_courses_taken : options[:number])).to_a
			current_courses = UniversityCourseGrade.where(course_number: target_courses,university_grade_id: university_grade.id).kept.pluck(:course_number).uniq.map{|v| v.to_i}

			new_courses = target_courses - current_courses

			new_courses.each do |course|
				UniversityCourseGrade.find_or_create_by({university_grade_id: university_grade.id , course_number: course})
			end
			result = UniversityCourseGrade.where(course_number: target_courses,university_grade_id: university_grade.id).kept.order(:course_number)
		end
		return result
	end




	def applicationFormDisbursementRequest section, student, application

		max_funding = application.resource.funding_opportunity.funding_disbursement.max_tuition_percentage
		
		if application.disbursement_request.nil?
			result = DisbursementRequest.create({application_id: application.id,status: 'active',request_case: 'student_request',tuition_funded_percentage: max_funding})
		else
			result = application.disbursement_request
			result.update(tuition_funded_percentage: max_funding)
		end

		if application.resource.disbursement_case == "living_expenses" || application.resource.disbursement_case == 'emergency_living_expenses'
			result.living_expenses_value = application.resource.student_value
			result.disbursement_value = application.resource.student_value
		end


		return result
	end

	def applicationFormSchoolGrade section, student, application
		school = student.student_academic_information.find_by_reference_case('school')
		if school.nil?
			school = result = StudentAcademicInformation.create(user_id: student.id, information_case: 'school',application_id: application.id)
		end
		result = school.school_grade
		if result.nil?
			result = SchoolGrade.create(student_academic_information_id: school.id)
		end
		return result
	end

	def applicationFormInfoTerpel section, student, application
		result = student.info_terpel
		if result.nil?
			result = InfoTerpel.create({user_id: student.id})
		end
		return result
	end
	def applicationFormStudent section, student, application
		student
	end

	def applicationFormContactInfo section, student, application
		student.contact_info
	end

	def applicationFormLocation section, student, application
		student.location
	end

	def applicationFormPersonalInformation section, student, application
		student.personal_information
	end

	def applicationFormAcademicStop section, student, application
		student.funded_academic_information.academic_stop.last
	end

	def applicationFormFundWithdrawal section, student, application
		student.active_isa.last.fund_withdrawal
	end

	def applicationFormSociodemographic section, student, application

		result = student.sociodemographic
		if result.nil?
			result = Sociodemographic.create({user_id: student.id})
		end
		return result
	end

	def applicationFormChild section, student, application
		student.child
	end
	def applicationFormHealth section, student, application
		result = student.health
		if result.nil?
			result = Health.create({user_id: student.id})
		end
		return result
	end
	def applicationFormBffQuestion section, student, application
		result = student.bff_question
		if result.nil?
			result = BffQuestion.create({user_id: student.id})
		end
	end
	def applicationFormReference section, student, application
		# the options are: ['guardian','conditional_guardian','jointly_liable','personal_reference','familiar_reference']

		options = eval(section.options)

		if options[:case] == 'conditional_guardian' && student.adult?(application.funding_opportunity.company.country)
			options[:case] = 'familiar_reference'
		elsif options[:case] == 'conditional_guardian' && !student.adult?(application.funding_opportunity.company.country)
			options[:case] = 'guardian'
		end

		result = student.reference.find_by(reference_case: options[:case],row: options[:row].to_i)



		if result.nil?
			case options[:case]
			when 'guardian'
				result = Reference.create({user_id: student.id,reference_case: options[:case],row: options[:row],guardian_check: true})
			when 'jointly_liable'
				result = Reference.create({user_id: student.id,reference_case: options[:case],row: options[:row],jointly_liable: true})
			else
				result = Reference.create({user_id: student.id,reference_case: options[:case],row: options[:row],guardian_check: false,jointly_liable: false})
			end
		end
		return result
	end

	def applicationFormPayment section, student, application
		case application.resource_type
		when 'Payment'
			result = application.resource
		end
		return result
	end

	def applicationFormIncomeInformation section, student, application

		case application.resource_type
		when 'IncomeInformation'
			result = application.resource
			if result.currency.nil?
				result.country_id = application.funding_opportunity.fund.company.country_id
				result.currency = application.funding_opportunity.fund.company.country.currency
			end
		else
			result = student.income_information
		end
	
		return result
	end

	def applicationFormBankAccount section, student, application
		if application.application_case == 'disbursement_request'
			result = student.bank_account.select{|ba| ba.active == true}.last
		else
			result = application.resource
		end
		if result.nil?
			result = BankAccount.create({resource: student,active: true})
		end
		return result
	end

	def applicationFormDisbursement section, student, application
		@application.disbursement
	end
	def applicationFormIsaStatus section, student, application
		@application.isa.isa_status
	end
	def applicationFormIsa section, student, application
		@application.isa
	end
	def applicationFormFundingOption section, student, application
		@application.funding_option
	end
	def applicationFormStudentAcademicInformation section, student, application
		case application.resource_type
		when 'AcademicRequest'
			result = application.resource.student_academic_information
		when 'FundingOpportunity'
			options = eval(section.options)
			disbursement_setup = application.funding_opportunity.funding_disbursement
			living_expenses_value = disbursement_setup.living_expenses_value.to_f

			case options[:case]
			when 'to_be_funded','school','to_be_funded_attachments','school_attachments','university', 'university_attachments'
				# The attachments cases prevent default behavior on view
				if options[:case] == 'to_be_funded_attachments'
					options[:case] = 'to_be_funded'
				elsif options[:case] == 'school_attachments'
					options[:case] = 'school'
				end

				result = StudentAcademicInformation.where(user_id: student.id, information_case: options[:case],application_id: application.id).first
				if result.nil?
					result = StudentAcademicInformation.create(user_id: student.id, information_case: options[:case],application_id: application.id,
						tuition_funded_percentage: disbursement_setup.max_tuition_percentage,living_expenses_value: living_expenses_value,living_expenses_check: (living_expenses_value > 0))
				end
			else
				result = StudentAcademicInformation.where(user_id: student.id, information_case: options[:case])
			end
		when 'Disbursement'
			result = application.resource.application.funded_major
		when 'StudentAcademicInformation'
			result = application.resource
		end



		return result
	end
	def applicationFormStudentDebt section, student, application
		student.student_debt
	end
	def applicationFormStudentExpense section, student, application
		student.student_expense
	end
	def applicationFormStudentFinancialInformation section, student, application
		result = student.student_financial_information
		if result.nil?
			result = StudentFinancialInformation.create({user_id: current_user.id})
		end
		return result
	end
	def applicationFormStudentConfig section, student, application
		student.student_config
	end

end