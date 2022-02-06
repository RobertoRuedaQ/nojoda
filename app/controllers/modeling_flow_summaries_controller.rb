class ModelingFlowSummariesController < ApplicationController
	def index
		@modeling_flow_summary = ModelingFlowSummary.lumniStart(params,current_company, list: current_user.template('ModelingFlowSummary','modeling_flow_summaries',current_user))
		contactModelingFlowSummary = @modeling_flow_summary.lumniSave(params,current_user, list: current_user.template('ModelingFlowSummary','modeling_flow_summaries',current_user))
		lumniClose(@modeling_flow_summary,contactModelingFlowSummary)
	end

	def new
		@modeling_flow_summary = ModelingFlowSummary.lumniStart(params,current_company, list: current_user.template('ModelingFlowSummary','modeling_flow_summaries',current_user))
		contactModelingFlowSummary = @modeling_flow_summary.lumniSave(params,current_user, list: current_user.template('ModelingFlowSummary','modeling_flow_summaries',current_user))
		lumniClose(@modeling_flow_summary,contactModelingFlowSummary)
	end

	def create
		@modeling_flow_summary = ModelingFlowSummary.lumniStart(params,current_company, list: current_user.template('ModelingFlowSummary','modeling_flow_summaries',current_user))
		contactModelingFlowSummary = @modeling_flow_summary.lumniSave(params,current_user, list: current_user.template('ModelingFlowSummary','modeling_flow_summaries',current_user))
		lumniClose(@modeling_flow_summary,contactModelingFlowSummary)
	end

	def edit
		@modeling_flow_summary = ModelingFlowSummary.lumniStart(params,current_company, list: current_user.template('ModelingFlowSummary','modeling_flow_summaries',current_user))
		contactModelingFlowSummary = @modeling_flow_summary.lumniSave(params,current_user, list: current_user.template('ModelingFlowSummary','modeling_flow_summaries',current_user))
		lumniClose(@modeling_flow_summary,contactModelingFlowSummary)
	end

	def update
		@modeling_flow_summary = ModelingFlowSummary.lumniStart(params,current_company, list: current_user.template('ModelingFlowSummary','modeling_flow_summaries',current_user))
		contactModelingFlowSummary = @modeling_flow_summary.lumniSave(params,current_user, list: current_user.template('ModelingFlowSummary','modeling_flow_summaries',current_user))
		lumniClose(@modeling_flow_summary,contactModelingFlowSummary)
	end
	def destroy
		@modeling_flow_summary = ModelingFlowSummary.lumniStart(params,current_company, list: current_user.template('ModelingFlowSummary','modeling_flow_summaries',current_user))
		contactModelingFlowSummary = @modeling_flow_summary.lumniSave(params,current_user, list: current_user.template('ModelingFlowSummary','modeling_flow_summaries',current_user))
		lumniClose(@cluster,contactModelingFlowSummary)
	end
end