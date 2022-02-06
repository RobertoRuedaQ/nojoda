class ModelingFlowExtrasController < ApplicationController
	def index
		@modeling_flow_extra = ModelingFlowExtra.lumniStart(params,current_company, list: current_user.template('ModelingFlowExtra','modeling_flow_extras',current_user))
		contactModelingFlowExtra = @modeling_flow_extra.lumniSave(params,current_user, list: current_user.template('ModelingFlowExtra','modeling_flow_extras',current_user))
		lumniClose(@modeling_flow_extra,contactModelingFlowExtra)
	end

	def new
		@modeling_flow_extra = ModelingFlowExtra.lumniStart(params,current_company, list: current_user.template('ModelingFlowExtra','modeling_flow_extras',current_user))
		contactModelingFlowExtra = @modeling_flow_extra.lumniSave(params,current_user, list: current_user.template('ModelingFlowExtra','modeling_flow_extras',current_user))
		lumniClose(@modeling_flow_extra,contactModelingFlowExtra)
	end

	def create
		@modeling_flow_extra = ModelingFlowExtra.lumniStart(params,current_company, list: current_user.template('ModelingFlowExtra','modeling_flow_extras',current_user))
		contactModelingFlowExtra = @modeling_flow_extra.lumniSave(params,current_user, list: current_user.template('ModelingFlowExtra','modeling_flow_extras',current_user))
		lumniClose(@modeling_flow_extra,contactModelingFlowExtra)
	end

	def edit
		@modeling_flow_extra = ModelingFlowExtra.lumniStart(params,current_company, list: current_user.template('ModelingFlowExtra','modeling_flow_extras',current_user))
		contactModelingFlowExtra = @modeling_flow_extra.lumniSave(params,current_user, list: current_user.template('ModelingFlowExtra','modeling_flow_extras',current_user))
		lumniClose(@modeling_flow_extra,contactModelingFlowExtra)
	end

	def update
		@modeling_flow_extra = ModelingFlowExtra.lumniStart(params,current_company, list: current_user.template('ModelingFlowExtra','modeling_flow_extras',current_user))
		contactModelingFlowExtra = @modeling_flow_extra.lumniSave(params,current_user, list: current_user.template('ModelingFlowExtra','modeling_flow_extras',current_user))
		lumniClose(@modeling_flow_extra,contactModelingFlowExtra)
	end
	def destroy
		@modeling_flow_extra = ModelingFlowExtra.lumniStart(params,current_company, list: current_user.template('ModelingFlowExtra','modeling_flow_extras',current_user))
		contactModelingFlowExtra = @modeling_flow_extra.lumniSave(params,current_user, list: current_user.template('ModelingFlowExtra','modeling_flow_extras',current_user))
		lumniClose(@cluster,contactModelingFlowExtra)
	end
end