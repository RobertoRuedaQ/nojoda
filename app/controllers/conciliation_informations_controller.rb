class ConciliationInformationsController < ApplicationController
	def index
		@conciliation_information = ConciliationInformation.lumniStart(params,current_company, list: current_user.template('ConciliationInformation','conciliation_informations',current_user))
		contactConciliationInformation = @conciliation_information.lumniSave(params,current_user, list: current_user.template('ConciliationInformation','conciliation_informations',current_user))
		lumniClose(@conciliation_information,contactConciliationInformation)
	end

	def new
		@conciliation_information = ConciliationInformation.lumniStart(params,current_company, list: current_user.template('ConciliationInformation','conciliation_informations',current_user))
		@conciliation_information.isa_id = params[:isa_id]
		years = ((Time.now - 10.years).year..(Time.now - 1.year).year).to_a.reverse
		@target_options = {list: {years: {values: years,labels: years}},field_type: 'list',type: 'list',value: (Time.now - 1.year).year}
		contactConciliationInformation = @conciliation_information.lumniSave(params,current_user, list: current_user.template('ConciliationInformation','conciliation_informations',current_user))
		lumniClose(@conciliation_information,contactConciliationInformation)
	end

	def create
		@conciliation_information = ConciliationInformation.lumniStart(params,current_company, list: current_user.template('ConciliationInformation','conciliation_informations',current_user))
		contactConciliationInformation = @conciliation_information.lumniSave(params,current_user, list: current_user.template('ConciliationInformation','conciliation_informations',current_user))
		lumniClose(@conciliation_information,contactConciliationInformation)
	end

	def edit
		@conciliation_information = ConciliationInformation.lumniStart(params,current_company, list: current_user.template('ConciliationInformation','conciliation_informations',current_user))
		contactConciliationInformation = @conciliation_information.lumniSave(params,current_user, list: current_user.template('ConciliationInformation','conciliation_informations',current_user))
		lumniClose(@conciliation_information,contactConciliationInformation)
	end

	def update
		@conciliation_information = ConciliationInformation.lumniStart(params,current_company, list: current_user.template('ConciliationInformation','conciliation_informations',current_user))
		contactConciliationInformation = @conciliation_information.lumniSave(params,current_user, list: current_user.template('ConciliationInformation','conciliation_informations',current_user))
		lumniClose(@conciliation_information,contactConciliationInformation)
	end
	def destroy
		@conciliation_information = ConciliationInformation.lumniStart(params,current_company, list: current_user.template('ConciliationInformation','conciliation_informations',current_user))
		contactConciliationInformation = @conciliation_information.lumniSave(params,current_user, list: current_user.template('ConciliationInformation','conciliation_informations',current_user))
		lumniClose(@cluster,contactConciliationInformation)
	end




end