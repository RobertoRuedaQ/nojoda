class ModelingVariablesController < ApplicationController
	def index
		@modeling_variable = ModelingVariable.lumniStart(params,current_company, list: current_user.template('ModelingVariable','modeling_variables',current_user))
		contactModelingVariable = @modeling_variable.lumniSave(params,current_user, list: current_user.template('ModelingVariable','modeling_variables',current_user))
		lumniClose(@modeling_variable,contactModelingVariable)
	end

	def new
		@modeling_variable = ModelingVariable.lumniStart(params,current_company, list: current_user.template('ModelingVariable','modeling_variables',current_user))
		contactModelingVariable = @modeling_variable.lumniSave(params,current_user, list: current_user.template('ModelingVariable','modeling_variables',current_user))
		lumniClose(@modeling_variable,contactModelingVariable)
	end

	def create
		@modeling_variable = ModelingVariable.lumniStart(params,current_company, list: current_user.template('ModelingVariable','modeling_variables',current_user))
		contactModelingVariable = @modeling_variable.lumniSave(params,current_user, list: current_user.template('ModelingVariable','modeling_variables',current_user))
		lumniClose(@modeling_variable,contactModelingVariable)
	end

	def edit
		@modeling_variable = ModelingVariable.lumniStart(params,current_company, list: current_user.template('ModelingVariable','modeling_variables',current_user))
		contactModelingVariable = @modeling_variable.lumniSave(params,current_user, list: current_user.template('ModelingVariable','modeling_variables',current_user))
		lumniClose(@modeling_variable,contactModelingVariable)
	end

	def update
		@modeling_variable = ModelingVariable.lumniStart(params,current_company, list: current_user.template('ModelingVariable','modeling_variables',current_user))
		contactModelingVariable = @modeling_variable.lumniSave(params,current_user, list: current_user.template('ModelingVariable','modeling_variables',current_user))
		lumniClose(@modeling_variable,contactModelingVariable)
	end
	def destroy
		@modeling_variable = ModelingVariable.lumniStart(params,current_company, list: current_user.template('ModelingVariable','modeling_variables',current_user))
		contactModelingVariable = @modeling_variable.lumniSave(params,current_user, list: current_user.template('ModelingVariable','modeling_variables',current_user))
		lumniClose(@cluster,contactModelingVariable)
	end
end