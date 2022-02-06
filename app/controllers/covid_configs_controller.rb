class CovidConfigsController < ApplicationController
	def index
		@covid_config = CovidConfig.lumniStart(params,current_company, list: current_user.template('CovidConfig','covid_configs',current_user))
		contactCovidConfig = @covid_config.lumniSave(params,current_user, list: current_user.template('CovidConfig','covid_configs',current_user))
		lumniClose(@covid_config,contactCovidConfig)
	end

	def new
		@covid_config = CovidConfig.lumniStart(params,current_company, list: current_user.template('CovidConfig','covid_configs',current_user))
		contactCovidConfig = @covid_config.lumniSave(params,current_user, list: current_user.template('CovidConfig','covid_configs',current_user))
		lumniClose(@covid_config,contactCovidConfig)
	end

	def create
		@covid_config = CovidConfig.lumniStart(params,current_company, list: current_user.template('CovidConfig','covid_configs',current_user))
		contactCovidConfig = @covid_config.lumniSave(params,current_user, list: current_user.template('CovidConfig','covid_configs',current_user))
		lumniClose(@covid_config,contactCovidConfig)
	end

	def edit
		@covid_config = CovidConfig.lumniStart(params,current_company, list: current_user.template('CovidConfig','covid_configs',current_user))
		contactCovidConfig = @covid_config.lumniSave(params,current_user, list: current_user.template('CovidConfig','covid_configs',current_user))
		lumniClose(@covid_config,contactCovidConfig)
	end

	def update
		@covid_config = CovidConfig.lumniStart(params,current_company, list: current_user.template('CovidConfig','covid_configs',current_user))
		contactCovidConfig = @covid_config.lumniSave(params,current_user, list: current_user.template('CovidConfig','covid_configs',current_user))
		lumniClose(@covid_config,contactCovidConfig)
	end
	def destroy
		@covid_config = CovidConfig.lumniStart(params,current_company, list: current_user.template('CovidConfig','covid_configs',current_user))
		contactCovidConfig = @covid_config.lumniSave(params,current_user, list: current_user.template('CovidConfig','covid_configs',current_user))
		lumniClose(@cluster,contactCovidConfig)
	end
end