class ModelingSencibilitiesController < ApplicationController
	def index
		@modeling_sencibility = ModelingSencibility.lumniStart(params,current_company, list: current_user.template('ModelingSencibility','modeling_sencibilities',current_user))
		contactModelingSencibility = @modeling_sencibility.lumniSave(params,current_user, list: current_user.template('ModelingSencibility','modeling_sencibilities',current_user))
		lumniClose(@modeling_sencibility,contactModelingSencibility)
	end

	def new
		@modeling_sencibility = ModelingSencibility.lumniStart(params,current_company, list: current_user.template('ModelingSencibility','modeling_sencibilities',current_user))
		contactModelingSencibility = @modeling_sencibility.lumniSave(params,current_user, list: current_user.template('ModelingSencibility','modeling_sencibilities',current_user))
		lumniClose(@modeling_sencibility,contactModelingSencibility)
	end

	def create
		@modeling_sencibility = ModelingSencibility.lumniStart(params,current_company, list: current_user.template('ModelingSencibility','modeling_sencibilities',current_user))
		contactModelingSencibility = @modeling_sencibility.lumniSave(params,current_user, list: current_user.template('ModelingSencibility','modeling_sencibilities',current_user))
		lumniClose(@modeling_sencibility,contactModelingSencibility)
	end

	def edit
		@modeling_sencibility = ModelingSencibility.lumniStart(params,current_company, list: current_user.template('ModelingSencibility','modeling_sencibilities',current_user))
		contactModelingSencibility = @modeling_sencibility.lumniSave(params,current_user, list: current_user.template('ModelingSencibility','modeling_sencibilities',current_user))
		lumniClose(@modeling_sencibility,contactModelingSencibility)
	end

	def show
		@modeling_sencibility = ModelingSencibility.find(params[:id])
	end

	def update
		@modeling_sencibility = ModelingSencibility.lumniStart(params,current_company, list: current_user.template('ModelingSencibility','modeling_sencibilities',current_user))
		contactModelingSencibility = @modeling_sencibility.lumniSave(params,current_user, list: current_user.template('ModelingSencibility','modeling_sencibilities',current_user))
		lumniClose(@modeling_sencibility,contactModelingSencibility)
	end
	def destroy
		@modeling_sencibility = ModelingSencibility.lumniStart(params,current_company, list: current_user.template('ModelingSencibility','modeling_sencibilities',current_user))
		contactModelingSencibility = @modeling_sencibility.lumniSave(params,current_user, list: current_user.template('ModelingSencibility','modeling_sencibilities',current_user))
		lumniClose(@cluster,contactModelingSencibility)
	end
end