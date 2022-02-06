class CondonationsController < ApplicationController
	def index
		@condonation = Condonation.lumniStart(params,current_company, list: current_user.template('Condonation','condonations',current_user))
		contactCondonation = @condonation.lumniSave(params,current_user, list: current_user.template('Condonation','condonations',current_user))
		lumniClose(@condonation,contactCondonation)
	end

	def new
		@condonation = Condonation.lumniStart(params,current_company, list: current_user.template('Condonation','condonations',current_user))
		contactCondonation = @condonation.lumniSave(params,current_user, list: current_user.template('Condonation','condonations',current_user))
		lumniClose(@condonation,contactCondonation)
	end

	def create
		@condonation = Condonation.lumniStart(params,current_company, list: current_user.template('Condonation','condonations',current_user))
		contactCondonation = @condonation.lumniSave(params,current_user, list: current_user.template('Condonation','condonations',current_user))
		lumniClose(@condonation,contactCondonation)
	end

	def edit
		@condonation = Condonation.lumniStart(params,current_company, list: current_user.template('Condonation','condonations',current_user))
		contactCondonation = @condonation.lumniSave(params,current_user, list: current_user.template('Condonation','condonations',current_user))
		lumniClose(@condonation,contactCondonation)
	end

	def update
		@condonation = Condonation.lumniStart(params,current_company, list: current_user.template('Condonation','condonations',current_user))
		contactCondonation = @condonation.lumniSave(params,current_user, list: current_user.template('Condonation','condonations',current_user))
		lumniClose(@condonation,contactCondonation)
	end
	def destroy
		@condonation = Condonation.lumniStart(params,current_company, list: current_user.template('Condonation','condonations',current_user))
		contactCondonation = @condonation.lumniSave(params,current_user, list: current_user.template('Condonation','condonations',current_user))
		lumniClose(@cluster,contactCondonation)
	end
end