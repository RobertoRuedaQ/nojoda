class ModelingsController < ApplicationController
	def index
		@modeling = Modeling.lumniStart(params,current_company, list: current_user.template('Modeling','modelings',current_user))
		contactModeling = @modeling.lumniSave(params,current_user, list: current_user.template('Modeling','modelings',current_user))
		lumniClose(@modeling,contactModeling)
	end

	def new
		@modeling = Modeling.lumniStart(params,current_company, list: current_user.template('Modeling','modelings',current_user))
		contactModeling = @modeling.lumniSave(params,current_user, list: current_user.template('Modeling','modelings',current_user))
		lumniClose(@modeling,contactModeling)
	end

	def create
		@modeling = Modeling.lumniStart(params,current_company, list: current_user.template('Modeling','modelings',current_user))
		contactModeling = @modeling.lumniSave(params,current_user, list: current_user.template('Modeling','modelings',current_user))
		lumniClose(@modeling,contactModeling)
	end

	def edit
		@modeling = Modeling.lumniStart(params,current_company, list: current_user.template('Modeling','modelings',current_user))
		contactModeling = @modeling.lumniSave(params,current_user, list: current_user.template('Modeling','modelings',current_user))
		lumniClose(@modeling,contactModeling)
	end

	def update
		@modeling = Modeling.lumniStart(params,current_company, list: current_user.template('Modeling','modelings',current_user))
		contactModeling = @modeling.lumniSave(params,current_user, list: current_user.template('Modeling','modelings',current_user))
		lumniClose(@modeling,contactModeling)
	end
	def destroy
		@modeling = Modeling.lumniStart(params,current_company, list: current_user.template('Modeling','modelings',current_user))
		contactModeling = @modeling.lumniSave(params,current_user, list: current_user.template('Modeling','modelings',current_user))
		lumniClose(@cluster,contactModeling)
	end

end