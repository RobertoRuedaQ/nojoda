class ModelingFlowDetailsController < ApplicationController
	def index
		@modeling_flow_detail = ModelingFlowDetail.lumniStart(params,current_company, list: current_user.template('ModelingFlowDetail','modeling_flow_details',current_user))
		contactModelingFlowDetail = @modeling_flow_detail.lumniSave(params,current_user, list: current_user.template('ModelingFlowDetail','modeling_flow_details',current_user))
		lumniClose(@modeling_flow_detail,contactModelingFlowDetail)
	end

	def new
		@modeling_flow_detail = ModelingFlowDetail.lumniStart(params,current_company, list: current_user.template('ModelingFlowDetail','modeling_flow_details',current_user))
		contactModelingFlowDetail = @modeling_flow_detail.lumniSave(params,current_user, list: current_user.template('ModelingFlowDetail','modeling_flow_details',current_user))
		lumniClose(@modeling_flow_detail,contactModelingFlowDetail)
	end

	def create
		@modeling_flow_detail = ModelingFlowDetail.lumniStart(params,current_company, list: current_user.template('ModelingFlowDetail','modeling_flow_details',current_user))
		contactModelingFlowDetail = @modeling_flow_detail.lumniSave(params,current_user, list: current_user.template('ModelingFlowDetail','modeling_flow_details',current_user))
		lumniClose(@modeling_flow_detail,contactModelingFlowDetail)
	end

	def edit
		@modeling_flow_detail = ModelingFlowDetail.lumniStart(params,current_company, list: current_user.template('ModelingFlowDetail','modeling_flow_details',current_user))
		contactModelingFlowDetail = @modeling_flow_detail.lumniSave(params,current_user, list: current_user.template('ModelingFlowDetail','modeling_flow_details',current_user))
		lumniClose(@modeling_flow_detail,contactModelingFlowDetail)
	end

	def update
		@modeling_flow_detail = ModelingFlowDetail.lumniStart(params,current_company, list: current_user.template('ModelingFlowDetail','modeling_flow_details',current_user))
		contactModelingFlowDetail = @modeling_flow_detail.lumniSave(params,current_user, list: current_user.template('ModelingFlowDetail','modeling_flow_details',current_user))
		lumniClose(@modeling_flow_detail,contactModelingFlowDetail)
	end
	def destroy
		@modeling_flow_detail = ModelingFlowDetail.lumniStart(params,current_company, list: current_user.template('ModelingFlowDetail','modeling_flow_details',current_user))
		contactModelingFlowDetail = @modeling_flow_detail.lumniSave(params,current_user, list: current_user.template('ModelingFlowDetail','modeling_flow_details',current_user))
		lumniClose(@cluster,contactModelingFlowDetail)
	end
end