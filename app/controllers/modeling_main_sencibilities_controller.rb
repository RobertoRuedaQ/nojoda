class ModelingMainSencibilitiesController < ApplicationController
	def index
		@modeling_main_sencibility = ModelingMainSencibility.lumniStart(params,current_company, list: current_user.template('ModelingMainSencibility','modeling_main_sencibilities',current_user))
		contactModelingMainSencibility = @modeling_main_sencibility.lumniSave(params,current_user, list: current_user.template('ModelingMainSencibility','modeling_main_sencibilities',current_user))
		lumniClose(@modeling_main_sencibility,contactModelingMainSencibility)
	end

	def new
		@modeling_main_sencibility = ModelingMainSencibility.lumniStart(params,current_company, list: current_user.template('ModelingMainSencibility','modeling_main_sencibilities',current_user))
		contactModelingMainSencibility = @modeling_main_sencibility.lumniSave(params,current_user, list: current_user.template('ModelingMainSencibility','modeling_main_sencibilities',current_user))
		lumniClose(@modeling_main_sencibility,contactModelingMainSencibility)
	end

	def create
		@modeling_main_sencibility = ModelingMainSencibility.lumniStart(params,current_company, list: current_user.template('ModelingMainSencibility','modeling_main_sencibilities',current_user))
		contactModelingMainSencibility = @modeling_main_sencibility.lumniSave(params,current_user, list: current_user.template('ModelingMainSencibility','modeling_main_sencibilities',current_user))
		lumniClose(@modeling_main_sencibility,contactModelingMainSencibility)
	end

	def show
		@modeling_main_sencibility = ModelingMainSencibility.joins(:modeling_sencibilities).find(params[:id])
		@table_term = ModelingSencibilityDetail.joins(:modeling_sencibility).where(modeling_sencibilities: {modeling_main_sencibility_id: params[:id]}).group('modeling_sencibilities.delta_default','modeling_sencibilities.delta_unemployment','modeling_sencibilities.delta_dropout').average(:term)
		@table_study_percentage = ModelingSencibilityDetail.joins(:modeling_sencibility).where(modeling_sencibilities: {modeling_main_sencibility_id: params[:id]}).group('modeling_sencibilities.delta_default','modeling_sencibilities.delta_unemployment','modeling_sencibilities.delta_dropout').average(:study_percentage)
		@table_graduated_percentage = ModelingSencibilityDetail.joins(:modeling_sencibility).where(modeling_sencibilities: {modeling_main_sencibility_id: params[:id]}).group('modeling_sencibilities.delta_default','modeling_sencibilities.delta_unemployment','modeling_sencibilities.delta_dropout').average(:graduated_percentage)
		@table_total_disbursement = ModelingSencibilityDetail.joins(:modeling_sencibility).where(modeling_sencibilities: {modeling_main_sencibility_id: params[:id]}).group('modeling_sencibilities.delta_default','modeling_sencibilities.delta_unemployment','modeling_sencibilities.delta_dropout').average(:total_disbursement)
		@delta_default_values = @modeling_main_sencibility.modeling_sencibilities.pluck(:delta_default).uniq
		@delta_unemployment_values = @modeling_main_sencibility.modeling_sencibilities.pluck(:delta_unemployment).uniq
		@delta_dropout_values = @modeling_main_sencibility.modeling_sencibilities.pluck(:delta_dropout).uniq
	end

	def edit
		@modeling_main_sencibility = ModelingMainSencibility.lumniStart(params,current_company, list: current_user.template('ModelingMainSencibility','modeling_main_sencibilities',current_user))
		contactModelingMainSencibility = @modeling_main_sencibility.lumniSave(params,current_user, list: current_user.template('ModelingMainSencibility','modeling_main_sencibilities',current_user))
		lumniClose(@modeling_main_sencibility,contactModelingMainSencibility)
	end

	def update
		@modeling_main_sencibility = ModelingMainSencibility.lumniStart(params,current_company, list: current_user.template('ModelingMainSencibility','modeling_main_sencibilities',current_user))
		contactModelingMainSencibility = @modeling_main_sencibility.lumniSave(params,current_user, list: current_user.template('ModelingMainSencibility','modeling_main_sencibilities',current_user))
		lumniClose(@modeling_main_sencibility,contactModelingMainSencibility)
	end
	def destroy
		@modeling_main_sencibility = ModelingMainSencibility.lumniStart(params,current_company, list: current_user.template('ModelingMainSencibility','modeling_main_sencibilities',current_user))
		contactModelingMainSencibility = @modeling_main_sencibility.lumniSave(params,current_user, list: current_user.template('ModelingMainSencibility','modeling_main_sencibilities',current_user))
		lumniClose(@cluster,contactModelingMainSencibility)
	end
end