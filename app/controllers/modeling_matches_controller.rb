class ModelingMatchesController < ApplicationController
	def index
		@modeling_match = ModelingMatch.lumniStart(params,current_company, list: current_user.template('ModelingMatch','modeling_matches',current_user))
		contactModelingMatch = @modeling_match.lumniSave(params,current_user, list: current_user.template('ModelingMatch','modeling_matches',current_user))
		lumniClose(@modeling_match,contactModelingMatch)
	end

	def new
		@modeling_match = ModelingMatch.lumniStart(params,current_company, list: current_user.template('ModelingMatch','modeling_matches',current_user))
		contactModelingMatch = @modeling_match.lumniSave(params,current_user, list: current_user.template('ModelingMatch','modeling_matches',current_user))
		lumniClose(@modeling_match,contactModelingMatch)
	end

	def create
		@modeling_match = ModelingMatch.lumniStart(params,current_company, list: current_user.template('ModelingMatch','modeling_matches',current_user))
		contactModelingMatch = @modeling_match.lumniSave(params,current_user, list: current_user.template('ModelingMatch','modeling_matches',current_user))
		if @modeling_match.application.resource_type == "Isa"
			redirect_to edit_application_path(@modeling_match.application)
		else
		redirect_to root_path
		end
	end

	def edit
		@modeling_match = ModelingMatch.lumniStart(params,current_company, list: current_user.template('ModelingMatch','modeling_matches',current_user))
		contactModelingMatch = @modeling_match.lumniSave(params,current_user, list: current_user.template('ModelingMatch','modeling_matches',current_user))
		lumniClose(@modeling_match,contactModelingMatch)
	end

	def update
		@modeling_match = ModelingMatch.lumniStart(params,current_company, list: current_user.template('ModelingMatch','modeling_matches',current_user))
		contactModelingMatch = @modeling_match.lumniSave(params,current_user, list: current_user.template('ModelingMatch','modeling_matches',current_user))
		lumniClose(@modeling_match,contactModelingMatch)
	end
	def destroy
		@modeling_match = ModelingMatch.lumniStart(params,current_company, list: current_user.template('ModelingMatch','modeling_matches',current_user))
		contactModelingMatch = @modeling_match.lumniSave(params,current_user, list: current_user.template('ModelingMatch','modeling_matches',current_user))
		lumniClose(@cluster,contactModelingMatch)
	end
end