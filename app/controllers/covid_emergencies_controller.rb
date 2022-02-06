class CovidEmergenciesController < ApplicationController
	def index
		@covid_emergency = CovidEmergency.lumniStart(params,current_company, list: current_user.template('CovidEmergency','covid_emergencies',current_user))
		contactCovidEmergency = @covid_emergency.lumniSave(params,current_user, list: current_user.template('CovidEmergency','covid_emergencies',current_user))
		lumniClose(@covid_emergency,contactCovidEmergency)
	end

	def new
		@covid_emergency = CovidEmergency.lumniStart(params,current_company, list: current_user.template('CovidEmergency','covid_emergencies',current_user))
		contactCovidEmergency = @covid_emergency.lumniSave(params,current_user, list: current_user.template('CovidEmergency','covid_emergencies',current_user))
		lumniClose(@covid_emergency,contactCovidEmergency)
	end

	def create
		@covid_emergency = CovidEmergency.lumniStart(params,current_company, list: current_user.template('CovidEmergency','covid_emergencies',current_user))
		contactCovidEmergency = @covid_emergency.lumniSave(params,current_user, list: current_user.template('CovidEmergency','covid_emergencies',current_user))
		lumniClose(@covid_emergency,contactCovidEmergency)
	end

	def edit
		@covid_emergency = CovidEmergency.lumniStart(params,current_company, list: current_user.template('CovidEmergency','covid_emergencies',current_user))
		contactCovidEmergency = @covid_emergency.lumniSave(params,current_user, list: current_user.template('CovidEmergency','covid_emergencies',current_user))
		lumniClose(@covid_emergency,contactCovidEmergency)
	end

	def update
		@covid_emergency = CovidEmergency.lumniStart(params,current_company, list: current_user.template('CovidEmergency','covid_emergencies',current_user))
		contactCovidEmergency = @covid_emergency.lumniSave(params,current_user, list: current_user.template('CovidEmergency','covid_emergencies',current_user))
		lumniClose(@covid_emergency,contactCovidEmergency)
	end
	def destroy
		@covid_emergency = CovidEmergency.lumniStart(params,current_company, list: current_user.template('CovidEmergency','covid_emergencies',current_user))
		contactCovidEmergency = @covid_emergency.lumniSave(params,current_user, list: current_user.template('CovidEmergency','covid_emergencies',current_user))
		lumniClose(@cluster,contactCovidEmergency)
	end

	def set_covid_option
		billing_document = BillingDocument.cached_find(params[:covidemergency][:billing_document_id])
		covid_config = billing_document.covid_config
		if !covid_config.nil? 
			if billing_document.user.personal_covid_emergency.present?
				covid_config.normal = 'Automático'
				covid_config.due_date = 'Automático'
				covid_config.custom_adjustment = 'Con Revisión'
				covid_config.no_payment = 'Con Revisión'
			end
			
			case covid_config.send(params[:covidemergency][:option])
			when 'Automático'
				temp_covid = billing_document.covid_emergency
				if temp_covid.count == 0
					covid_emergency = CovidEmergency.create(params_for_emergency)
				end
			when 'Con Revisión'
				temp_covid = billing_document.covid_emergency
				if temp_covid.count == 0
					covid_emergency = CovidEmergency.create(billing_document_id: params[:covidemergency][:billing_document_id],
						status: 'under_review',start_date: params[:covidemergency][:start_date],end_date: params[:covidemergency][:end_date])
					covid_emergency.attributes = params_for_emergency
					request = current_user.request_for_update(covid_emergency,reason: 'application update')
					request.save
					covid_emergency.flush_commit_cache

					application = Application.create({user_id: billing_document.user.id, application_case: "covid", resource_type: "CovidEmergency", resource_id: covid_emergency.id,status: 'submitted'})
					section = OriginationSection.cached_find(1203)
					ApplicationSectionTrack.create(application_id: application.id,origination_section_id: section.id)
					application.update(step: section.origination_module.origination.current_step(application))
				end
			end
		end

        redirect_to billing_document_path(params[:covidemergency][:billing_document_id])



	end

private
	def params_for_emergency
		params[:covidemergency] = params[:covidemergency].except(:support) if params[:covidemergency][:support] == ''
		params.require(:covidemergency).permit(:option, :start_date, :end_date, :billing_document_id, :status, :details,:support)
	end
end