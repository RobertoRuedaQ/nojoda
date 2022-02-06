class PersonalCovidEmergenciesController < ApplicationController
	def index
		@personal_covid_emergency = PersonalCovidEmergency.lumniStart(params,current_company, list: current_user.template('PersonalCovidEmergency','personal_covid_emergencies',current_user))
		contactPersonalCovidEmergency = @personal_covid_emergency.lumniSave(params,current_user, list: current_user.template('PersonalCovidEmergency','personal_covid_emergencies',current_user))
		lumniClose(@personal_covid_emergency,contactPersonalCovidEmergency)
	end

	def new
		@personal_covid_emergency = PersonalCovidEmergency.lumniStart(params,current_company, list: current_user.template('PersonalCovidEmergency','personal_covid_emergencies',current_user))
		contactPersonalCovidEmergency = @personal_covid_emergency.lumniSave(params,current_user, list: current_user.template('PersonalCovidEmergency','personal_covid_emergencies',current_user))
		lumniClose(@personal_covid_emergency,contactPersonalCovidEmergency)
	end

	def create
		@personal_covid_emergency = PersonalCovidEmergency.lumniStart(params,current_company, list: current_user.template('PersonalCovidEmergency','personal_covid_emergencies',current_user))
		contactPersonalCovidEmergency = @personal_covid_emergency.lumniSave(params,current_user, list: current_user.template('PersonalCovidEmergency','personal_covid_emergencies',current_user))
		lumniClose(@personal_covid_emergency,contactPersonalCovidEmergency)
	end

	def edit
		@personal_covid_emergency = PersonalCovidEmergency.lumniStart(params,current_company, list: current_user.template('PersonalCovidEmergency','personal_covid_emergencies',current_user))
		contactPersonalCovidEmergency = @personal_covid_emergency.lumniSave(params,current_user, list: current_user.template('PersonalCovidEmergency','personal_covid_emergencies',current_user))
		lumniClose(@personal_covid_emergency,contactPersonalCovidEmergency)
	end

	def update
		@personal_covid_emergency = PersonalCovidEmergency.lumniStart(params,current_company, list: current_user.template('PersonalCovidEmergency','personal_covid_emergencies',current_user))
		contactPersonalCovidEmergency = @personal_covid_emergency.lumniSave(params,current_user, list: current_user.template('PersonalCovidEmergency','personal_covid_emergencies',current_user))
		lumniClose(@personal_covid_emergency,contactPersonalCovidEmergency)
	end
	def destroy
		@personal_covid_emergency = PersonalCovidEmergency.lumniStart(params,current_company, list: current_user.template('PersonalCovidEmergency','personal_covid_emergencies',current_user))
		contactPersonalCovidEmergency = @personal_covid_emergency.lumniSave(params,current_user, list: current_user.template('PersonalCovidEmergency','personal_covid_emergencies',current_user))
		lumniClose(@cluster,contactPersonalCovidEmergency)
	end
end