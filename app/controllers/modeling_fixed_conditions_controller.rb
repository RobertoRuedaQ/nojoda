class ModelingFixedConditionsController < ApplicationController
	def index
		@modeling_fixed_condition = ModelingFixedCondition.lumniStart(params,current_company, list: current_user.template('ModelingFixedCondition','modeling_fixed_conditions',current_user))
		contactModelingFixedCondition = @modeling_fixed_condition.lumniSave(params,current_user, list: current_user.template('ModelingFixedCondition','modeling_fixed_conditions',current_user))
		lumniClose(@modeling_fixed_condition,contactModelingFixedCondition)
	end

	def new
		@modeling_fixed_condition = ModelingFixedCondition.lumniStart(params,current_company, list: current_user.template('ModelingFixedCondition','modeling_fixed_conditions',current_user))
		@modeling_fixed_condition.modeling_id = params[:modeling]
		contactModelingFixedCondition = @modeling_fixed_condition.lumniSave(params,current_user, list: current_user.template('ModelingFixedCondition','modeling_fixed_conditions',current_user))
		lumniClose(@modeling_fixed_condition,contactModelingFixedCondition)
	end

	def create
		@modeling_fixed_condition = ModelingFixedCondition.lumniStart(params,current_company, list: current_user.template('ModelingFixedCondition','modeling_fixed_conditions',current_user))
		contactModelingFixedCondition = @modeling_fixed_condition.lumniSave(params,current_user, list: current_user.template('ModelingFixedCondition','modeling_fixed_conditions',current_user))
		redirect_to edit_modeling_path(@modeling_fixed_condition.modeling_id)

	end

	def edit
		@modeling_fixed_condition = ModelingFixedCondition.lumniStart(params,current_company, list: current_user.template('ModelingFixedCondition','modeling_fixed_conditions',current_user))
		contactModelingFixedCondition = @modeling_fixed_condition.lumniSave(params,current_user, list: current_user.template('ModelingFixedCondition','modeling_fixed_conditions',current_user))
		lumniClose(@modeling_fixed_condition,contactModelingFixedCondition)
	end

	def update
		@modeling_fixed_condition = ModelingFixedCondition.lumniStart(params,current_company, list: current_user.template('ModelingFixedCondition','modeling_fixed_conditions',current_user))
		contactModelingFixedCondition = @modeling_fixed_condition.lumniSave(params,current_user, list: current_user.template('ModelingFixedCondition','modeling_fixed_conditions',current_user))
		lumniClose(@modeling_fixed_condition,contactModelingFixedCondition)
	end
	def destroy
		@modeling_fixed_condition = ModelingFixedCondition.lumniStart(params,current_company, list: current_user.template('ModelingFixedCondition','modeling_fixed_conditions',current_user))
		contactModelingFixedCondition = @modeling_fixed_condition.lumniSave(params,current_user, list: current_user.template('ModelingFixedCondition','modeling_fixed_conditions',current_user))
		lumniClose(@cluster,contactModelingFixedCondition)
	end
end