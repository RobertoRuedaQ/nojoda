class ModelingFlowsController < ApplicationController
	def index
		@modeling_flow = ModelingFlow.lumniStart(params,current_company, list: current_user.template('ModelingFlow','modeling_flows',current_user)).where(funding_option_id: params[:funding_option_id])
		contactModelingFlow = @modeling_flow.lumniSave(params,current_user, list: current_user.template('ModelingFlow','modeling_flows',current_user))
		lumniClose(@modeling_flow,contactModelingFlow)
	end

	def new
		@modeling_flow = ModelingFlow.lumniStart(params,current_company, list: current_user.template('ModelingFlow','modeling_flows',current_user))
		contactModelingFlow = @modeling_flow.lumniSave(params,current_user, list: current_user.template('ModelingFlow','modeling_flows',current_user))
		lumniClose(@modeling_flow,contactModelingFlow)
	end

	def create
		@modeling_flow = ModelingFlow.lumniStart(params,current_company, list: current_user.template('ModelingFlow','modeling_flows',current_user))
		contactModelingFlow = @modeling_flow.lumniSave(params,current_user, list: current_user.template('ModelingFlow','modeling_flows',current_user))
		lumniClose(@modeling_flow,contactModelingFlow)
	end

	def edit
		@modeling_flow = ModelingFlow.lumniStart(params,current_company, list: current_user.template('ModelingFlow','modeling_flows',current_user))
		contactModelingFlow = @modeling_flow.lumniSave(params,current_user, list: current_user.template('ModelingFlow','modeling_flows',current_user))
		lumniClose(@modeling_flow,contactModelingFlow)
	end

	def update
		@modeling_flow = ModelingFlow.lumniStart(params,current_company, list: current_user.template('ModelingFlow','modeling_flows',current_user))
		contactModelingFlow = @modeling_flow.lumniSave(params,current_user, list: current_user.template('ModelingFlow','modeling_flows',current_user))
		lumniClose(@modeling_flow,contactModelingFlow)
	end
	def destroy
		@modeling_flow = ModelingFlow.lumniStart(params,current_company, list: current_user.template('ModelingFlow','modeling_flows',current_user))
		contactModelingFlow = @modeling_flow.lumniSave(params,current_user, list: current_user.template('ModelingFlow','modeling_flows',current_user))
		lumniClose(@cluster,contactModelingFlow)
	end
end