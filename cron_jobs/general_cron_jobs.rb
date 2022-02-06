module GeneralCronJobs
	include LumniBootcamps

	def refresh_pending_transactions
		PayuResponse.where(state: "PENDING").map(&:update_response)
	end

	def follow_up_finished_income_contract
		income_informations = IncomeInformation.where.not(end_date: nil).where(operations_status: 'active')
		income_informations.each do |income|
			if income.end_date < Date.today
				user = income.user
				supervisors = user.reporting_to
				supervisors.each do |staff|
					NotifyEndOfContractAsync.perform_async(user.id, staff.supervisor_id)
				end
			end
		end
	end

	def send_email_for_pending_disbursement_application
		Application.send_email_for_pending_disbursement_application
	end

	def ejemplo_corrida
		puts 'it works at it supposed to'
	end
end

