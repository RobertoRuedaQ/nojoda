module LumniBootcamps
	def activate_bootcamp_disbursements
		bootcamps = FundingOpportunity.where(bootcamp: true).where.not(test_period_end_date: nil).where('test_period_end_date <= ?', Time.now.to_date)

		# bootcamps_ids = [222]
		# bootcamps = FundingOpportunity.where(id: bootcamps_ids)

		applications = Application.where(resource_type: 'FundingOpportunity', resource_id:  bootcamps.ids)
		funding_options = FundingOption.where(application_id: applications.ids)
		isas = Isa.where(funding_option_id: funding_options.ids).where(stored_general_status: 'inactive')

		isas_id = isas.ids
		#isas_id = Isa.joins([funding_option: :disbursement], [funding_option: [application: :funding_opportunity_from_resource]]).where(funding_options: {applications: {funding_opportunities: {id: bootcamps.ids}}}).where(funding_options: {disbursements: {status: 'generated'}}).ids.uniq

		disbursements = Disbursement.joins(funding_option: :isa).where(funding_options: {isas: {id: isas_id}}).where(status: 'generated')
		disbursements.ids.include?(1520)

		disbursements.each do |disbursement|
			# Application
			application = Application.create({  status: 'active',user_id: disbursement.funding_option.isa.user_id, application_case: 'disbursement_request', resource_type: 'Disbursement', resource_id: disbursement.id})
			# Disbursement Request
			disbursement_request = DisbursementRequest.create({application_id: application.id, tuition_value: disbursement.student_value, status: 'active', due_date: Time.now.to_date, request_case: 'student_request', tuition_funded_percentage: 100.0, disbursement_value: disbursement.student_value, disbursement_case: 'college_tuition_payment', tuition_due_date_type: 'Ordinaria'})
			# Approve application
			application.update({ result: 'approved', status: 'pending', decision: 'approved'})
			# Disbursement Payment
			DisbursementPayment.create({disbursement_id: disbursement.id, disbursement_request_id: disbursement_request.id, value: disbursement.student_value, status: "payed"})

			# Update Disbursement status
			disbursement.update(status: 'approved')
			# Send
			CommunicationMailer.activating_isa_email( disbursement.funding_option.isa.user_id, disbursement.funding_option.isa.user.company_id).deliver
			
		end
	end	
end