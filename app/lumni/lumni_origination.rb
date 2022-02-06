module LumniOrigination 

	def originationRedirect origination_case,user_id
		case origination_case[0]
		when 'eligibility_criteria'
			redirect_to edit_application_path(origination_case[1])
		when 'credit_history','isa_contract'
			redirect_to root_path
		when 'application'
			redirect_to edit_application_path(origination_case[1])
		end
	end
	def lumniCreateAccount
	end



	def lumniConfirmEmail
		if self.student?
			self.team_profile_id = self.company.get_student_profile_id('confirm_email')
			self.save
			creationTasks = self.target_tasks_by_type 'account_creation'
			creationTasks.each do |task|
				task.make_all_done
			end

			applicationTask = self.target_tasks_by_type 'get_funding'
			if applicationTask.count == 0

				## Creating a new get_funding task
				applicationTypeMain = ProjectTaskType.find_by_title('get_funding')
				targetApplicationTask = ProjectTask.create({deadline: Time.now.to_date + 15.days,created_by_id: self.id, responsable_id: self.id,
					project_task_type_id: applicationTypeMain.id,project_card_id: self.own_project.project_card.first.id,position: 0, company_id: self.company_id,
					progress: 0,start_date: Time.now.to_date,locked: true})

				## Creating the select_funding_opportunity task
				applicationTypeChild = ProjectTaskType.find_by_title('select_funding_opportunity')
				targetFundingTask = ProjectTask.create({deadline: Time.now.to_date + 8.days,created_by_id: self.id, responsable_id: self.id,
					project_task_type_id: applicationTypeChild.id,project_card_id: self.own_project.project_card.first.id,position: 0, company_id: self.company_id,
					progress: 0,start_date: Time.now.to_date, parent_id: targetApplicationTask.id,locked: true})
			end
		end

	end

	def lumniApply
	end

	def lumniContractActivation
	end

	def lumniStudentActivation
	end

	def lumniStartPayment
	end

	def lumniEndPayments
	end

	def origination_legal_process params, user_id
		target_user = User.cached_find(user_id)
		if !params[:application].nil? && !params[:application][:id].nil?
			application = Application.cached_find(params[:application][:id])
			self.application_id = application.id
			self.save
			result = ['application',application.id]
		end


		case self.legal_document.document_type
		when 'eligibility_criteria'
			target_funding_opportunity = FundingOpportunity.cached_find(params[:funding_opportunity][:id])
			@application = Application.create({user_id: user_id,resource_id: params[:funding_opportunity][:id],resource_type: 'FundingOpportunity',step: 0,show_financial_proposals: false, status: 'active',application_case: 'origination'})
			self.application_id = @application.id
			self.save

			## Assigning the Student Manager
			
			if target_user.reporting_to.count == 0
				TeamSupervisor.create({supervisor_id: target_funding_opportunity.assigned_supervisor, team_member_id: target_user.id, support_role_id: 1})
			end

			## Marking as done the select_funding_opportunity task
			funding_task = target_user.target_tasks_by_type 'select_funding_opportunity'
			funding_task.map{|t|t.make_it_done}

			## Moving to On Progress the get_funding task
			pipeLineTask = target_user.target_tasks_by_type 'get_funding'
			pipeLineTask.cached_update_all({progress: 20,project_card_id: target_user.own_project.project_card.second.id})


			## Creating a new submit_application task
			submitApplicationTask = ProjectTaskType.find_by_title('submit_application')
			if !submitApplicationTask.nil? && !pipeLineTask.first.nil?
				targetFundingTask = ProjectTask.create({deadline: Time.now.to_date + 8.days,created_by_id: target_user.id, responsable_id: target_user.id,
					project_task_type_id: submitApplicationTask.id,project_card_id: target_user.own_project.project_card.second.id,position: 1, company_id: target_user.company_id,
					progress: 0,start_date: Time.now.to_date, parent_id: pipeLineTask.first.id,locked: true,resource: @application})
			end

			target_questionnaire_modules = @application.funding_opportunity.origination.origination_module.kept.where(option: 'questionnaire')

			result = ['eligibility_criteria',@application.id]
		when 'credit_history'
			result = ['credit_history',nil]
		when 'isa_contract_adult','isa_contract_young','amendment_adult','amendment_young'
			self.resource = target_user.current_application.selected_funding_option
			self.save

			result = ['isa_contract',nil]
		when 'privacy_policy'
		when 'terms_of_use'
		end
		return result
	end
end

