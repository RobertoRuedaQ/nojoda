module LumniDisbursement


	def disbursement_custom_hash modeling, user_id, funding_opportunity_id
		user = User.cached_find(user_id)
		funding_token = user.funding_token.find_by_funding_opportunity_id(funding_opportunity_id)
		temp_hash = {}
		if !funding_token.nil?
			funding_token.custom_disbursement.each_with_index do |disbursement,index|
				temp_hash[index] = {student_value: disbursement.student_value, 
					company_value: disbursement.company_value,
					forcasted_date: disbursement.forcasted_date,
					disbursement_case: disbursement.disbursement_case,
					currency: disbursement.currency,
				}
			end
		end
		return temp_hash
	end



	def disbursement_hash periodicity, inicial_date, number_disbursements, inicial_value,living_expenses_check,funding_disbursement

		temp_hash = setup_application_disbursements periodicity, inicial_date, number_disbursements, inicial_value, 'tuition',funding_disbursement,0
		if living_expenses_check

			living_inicial_value = funding_disbursement.living_expenses_value.to_f

			if living_inicial_value > 0
	
				living_periodicity = funding_disbursement.living_expenses_periodicity

				final_living_expenses_date = temp_hash.values.map{|h| h[:forcasted_date]}.max + (periodicity.to_i).months
				puts "final_living_expenses_date: #{final_living_expenses_date}"
				living_expenses_months = [(final_living_expenses_date.to_date.year * 12 + final_living_expenses_date.to_date.month) - (inicial_date.to_date.year * 12 + inicial_date.to_date.month), funding_disbursement.max_funding_months.to_i].min

				living_number_disbursements = (living_expenses_months.to_f / living_periodicity.to_f).floor

				total_tuition = temp_hash.values.map{|h| h[:student_value]}.inject(0){|sum,x| sum + x }	
				living_max_total = funding_disbursement.max_total_fundinding_value - total_tuition

				temp_living_expenses = setup_application_disbursements living_periodicity, inicial_date, living_number_disbursements, living_inicial_value, 'living_expenses',funding_disbursement, temp_hash.count, max_total: living_max_total
				temp_hash = temp_hash.merge(temp_living_expenses)
			end 
		end

		return temp_hash
	end

	def setup_application_disbursements periodicity, inicial_date, number_disbursements, inicial_value, disbursement_case,funding_disbursement,initial_hash_row, options = {} 
		periodicity = periodicity.to_i
		inicial_date = inicial_date.to_date
		number_disbursements = number_disbursements.to_i
		inicial_value = inicial_value.to_f


		max_total = options[:max_total].nil? ? funding_disbursement.max_total_fundinding_value : options[:max_total]
		max_funding_by_disbursement = funding_disbursement.max_funding_by_disbursement
		adjustment_rate = funding_disbursement.growth_rate
		max_period = funding_disbursement.max_funding_months.to_i
		puts "funding_disbursement: #{funding_disbursement.attributes}"

		puts "number_disbursements_setup: #{number_disbursements}"
		temp_number_disbursements = [number_disbursements,(max_period / periodicity)].min
		puts "max_period: #{max_period}"
		puts "periodicity: #{periodicity}"
		puts "temp_number_disbursements: #{temp_number_disbursements}"

		temp_hash = disbursement_forcasting temp_number_disbursements,inicial_date,periodicity,adjustment_rate,inicial_value,max_funding_by_disbursement,max_total, disbursement_case,initial_hash_row
		return temp_hash

	end


	def disbursement_forcasting number_disbursements,inicial_date,periodicity,adjustment_rate,inicial_value,max_funding_by_disbursement,max_total, disbursement_case,initial_hash_row
		puts "number_disbursementsf: #{number_disbursements}"
		temp_hash = disbursement_hash_calculation number_disbursements,inicial_date,periodicity,adjustment_rate,inicial_value,max_funding_by_disbursement,1,disbursement_case,initial_hash_row
		temp_total = temp_hash.values.map{|h| h[:student_value]}.inject(0){|sum,x| sum + x }
		total_factor = max_total.to_f / temp_total.to_f

		if total_factor < 1
			temp_hash = disbursement_hash_calculation number_disbursements,inicial_date,periodicity,adjustment_rate,inicial_value,max_funding_by_disbursement,total_factor,disbursement_case,initial_hash_row
		end

		return temp_hash		
	end

	def disbursement_hash_calculation number_disbursements,inicial_date,periodicity,adjustment_rate,inicial_value,max_funding_by_disbursement,total_factor,disbursement_case,initial_hash_row

		temp_hash = {}
		puts "number_disbursements: #{number_disbursements}" 
		number_disbursements.times.each do |n|
			temp_date = inicial_date + (periodicity.to_i * n).months
			temp_factor = (1 + adjustment_rate/100)**(temp_date.year - inicial_date.year)
			temp_value = ([inicial_value * temp_factor,max_funding_by_disbursement].min * total_factor).to_i
			temp_hash[n + initial_hash_row] = {forcasted_date: temp_date, student_value: temp_value,disbursement_case: disbursement_case}
		end

		puts "temp_hash: #{temp_hash}"

		return temp_hash
	end


end