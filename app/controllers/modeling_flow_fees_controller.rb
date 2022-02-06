class ModelingFlowFeesController < ApplicationController
	def index
		@modeling_flow_fee = ModelingFlowFee.lumniStart(params,current_company, list: current_user.template('ModelingFlowFee','modeling_flow_fees',current_user))
		contactModelingFlowFee = @modeling_flow_fee.lumniSave(params,current_user, list: current_user.template('ModelingFlowFee','modeling_flow_fees',current_user))
		lumniClose(@modeling_flow_fee,contactModelingFlowFee)
	end

	def new
		@modeling_flow_fee = ModelingFlowFee.lumniStart(params,current_company, list: current_user.template('ModelingFlowFee','modeling_flow_fees',current_user))
		contactModelingFlowFee = @modeling_flow_fee.lumniSave(params,current_user, list: current_user.template('ModelingFlowFee','modeling_flow_fees',current_user))
		lumniClose(@modeling_flow_fee,contactModelingFlowFee)
	end

	def create
		@modeling_flow_fee = ModelingFlowFee.lumniStart(params,current_company, list: current_user.template('ModelingFlowFee','modeling_flow_fees',current_user))
		contactModelingFlowFee = @modeling_flow_fee.lumniSave(params,current_user, list: current_user.template('ModelingFlowFee','modeling_flow_fees',current_user))
		lumniClose(@modeling_flow_fee,contactModelingFlowFee)
	end

	def edit
		@modeling_flow_fee = ModelingFlowFee.lumniStart(params,current_company, list: current_user.template('ModelingFlowFee','modeling_flow_fees',current_user))
		contactModelingFlowFee = @modeling_flow_fee.lumniSave(params,current_user, list: current_user.template('ModelingFlowFee','modeling_flow_fees',current_user))
		lumniClose(@modeling_flow_fee,contactModelingFlowFee)
	end

	def update
		@modeling_flow_fee = ModelingFlowFee.lumniStart(params,current_company, list: current_user.template('ModelingFlowFee','modeling_flow_fees',current_user))
		contactModelingFlowFee = @modeling_flow_fee.lumniSave(params,current_user, list: current_user.template('ModelingFlowFee','modeling_flow_fees',current_user))
		lumniClose(@modeling_flow_fee,contactModelingFlowFee)
	end
	def destroy
		@modeling_flow_fee = ModelingFlowFee.lumniStart(params,current_company, list: current_user.template('ModelingFlowFee','modeling_flow_fees',current_user))
		contactModelingFlowFee = @modeling_flow_fee.lumniSave(params,current_user, list: current_user.template('ModelingFlowFee','modeling_flow_fees',current_user))
		lumniClose(@cluster,contactModelingFlowFee)
	end
end