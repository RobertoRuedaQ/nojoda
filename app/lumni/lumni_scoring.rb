module LumniScoring
	def scoring_funding_period target_user
		target_user.funded_academic_information.level_and_term
	end

	def scoring_school_average target_user
		target_user.school_average_score
	end

	def scoring_years_from_school target_user
		target_user.last_school.current_academic_status
	end

	def scoring_program_level target_user
		target_user.funded_program.lumni_level
	end

	def scoring_program_area target_user
		target_user.funded_program.lumni_area
	end

	def scoring_program_core target_user
		target_user.funded_program.lumni_core
	end

	def scoring_age target_user
		target_user.age
	end

	def scoring_residence_v_institution target_user
		target_user.residence_v_institution
	end

	def scoring_colombia_range_personal_debt target_user
		target_user.colombia_range_personal_debt
	end

	def scoring_colombia_range_mortgage_debt target_user
		target_user.colombia_range_mortgage_debt
	end

	def scoring_colombia_range_education_debt target_user
		target_user.colombia_range_education_debt
	end

	def scoring_colombia_range_other_debt target_user
		target_user.colombia_range_other_debt
	end

	def scoring_colombia_range_total_debt target_user
		target_user.colombia_range_personal_debt
	end

	def scoring_colombia_salary_range target_user
		target_user.colombia_salary_range
	end

	def scoring_positive_balance target_user
		target_user.student_positive_balance
	end

	def scoring_dependent_number target_user
		target_user.sociodemographic.dependent_number
	end

	def scoring_children_number target_user
		target_user.sociodemographic.children_number
	end

	def scoring_marital_status target_user
		target_user.personal_information.marital_status
	end

	def scoring_siblings_position target_user
		target_user.sociodemographic.siblings_position
	end

	def scoring_who_pays_your_expenses target_user
		target_user.student_financial_information.who_pays_your_expenses
	end

	def scoring_children_average_age target_user
		target_user.children_range(target_user.children_average_age)
	end

	def scoring_university_scholarship target_user
		target_user.funded_academic_information.ackn_scholarship_check
	end

	def scoring_number_subjects_failed target_user
		target_user.funded_academic_information.university_info.number_subjects_failed
	end

	def scoring_family_living_together target_user
		target_user.sociodemographic.family_living_together
	end

	def scoring_siblings_number target_user
		target_user.sociodemographic.siblings_number
	end


	def scoring_school_scholarship target_user
		target_user.last_school.ackn_scholarship_check
	end

	def scoring_standardized_state_test_ranking target_user
		target_user.last_school.standardized_state_test_ranking
	end

end