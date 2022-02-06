class HealthsController < ApplicationController
	def index
		@health = Health.lumniStart(params,current_company, list: current_user.template('Health','healths',current_user))
		contactHealth = @health.lumniSave(params,current_user, list: current_user.template('Health','healths',current_user))
		lumniClose(@health,contactHealth)
	end

	def new
		@health = Health.lumniStart(params,current_company, list: current_user.template('Health','healths',current_user))
		contactHealth = @health.lumniSave(params,current_user, list: current_user.template('Health','healths',current_user))
		lumniClose(@health,contactHealth)
	end

	def create
		@health = Health.lumniStart(params,current_company, list: current_user.template('Health','healths',current_user))
		contactHealth = @health.lumniSave(params,current_user, list: current_user.template('Health','healths',current_user))
		lumniClose(@health,contactHealth)
	end

	def edit
		@health = Health.lumniStart(params,current_company, list: current_user.template('Health','healths',current_user))
		contactHealth = @health.lumniSave(params,current_user, list: current_user.template('Health','healths',current_user))
		lumniClose(@health,contactHealth)
	end

	def update
		@health = Health.lumniStart(params,current_company, list: current_user.template('Health','healths',current_user))
		contactHealth = @health.lumniSave(params,current_user, list: current_user.template('Health','healths',current_user))
		lumniClose(@health,contactHealth)
	end
	def destroy
		@health = Health.lumniStart(params,current_company, list: current_user.template('Health','healths',current_user))
		contactHealth = @health.lumniSave(params,current_user, list: current_user.template('Health','healths',current_user))
		lumniClose(@cluster,contactHealth)
	end
end