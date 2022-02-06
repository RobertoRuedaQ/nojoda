class ModelingSencibilityDetailsController < ApplicationController
	def index
		@modeling_sencibility_detail = ModelingSencibilityDetail.lumniStart(params,current_company, list: current_user.template('ModelingSencibilityDetail','modeling_sencibility_details',current_user))
		contactModelingSencibilityDetail = @modeling_sencibility_detail.lumniSave(params,current_user, list: current_user.template('ModelingSencibilityDetail','modeling_sencibility_details',current_user))
		lumniClose(@modeling_sencibility_detail,contactModelingSencibilityDetail)
	end

	def new
		@modeling_sencibility_detail = ModelingSencibilityDetail.lumniStart(params,current_company, list: current_user.template('ModelingSencibilityDetail','modeling_sencibility_details',current_user))
		contactModelingSencibilityDetail = @modeling_sencibility_detail.lumniSave(params,current_user, list: current_user.template('ModelingSencibilityDetail','modeling_sencibility_details',current_user))
		lumniClose(@modeling_sencibility_detail,contactModelingSencibilityDetail)
	end

	def create
		@modeling_sencibility_detail = ModelingSencibilityDetail.lumniStart(params,current_company, list: current_user.template('ModelingSencibilityDetail','modeling_sencibility_details',current_user))
		contactModelingSencibilityDetail = @modeling_sencibility_detail.lumniSave(params,current_user, list: current_user.template('ModelingSencibilityDetail','modeling_sencibility_details',current_user))
		lumniClose(@modeling_sencibility_detail,contactModelingSencibilityDetail)
	end

	def edit
		@modeling_sencibility_detail = ModelingSencibilityDetail.lumniStart(params,current_company, list: current_user.template('ModelingSencibilityDetail','modeling_sencibility_details',current_user))
		contactModelingSencibilityDetail = @modeling_sencibility_detail.lumniSave(params,current_user, list: current_user.template('ModelingSencibilityDetail','modeling_sencibility_details',current_user))
		lumniClose(@modeling_sencibility_detail,contactModelingSencibilityDetail)
	end

	def update
		@modeling_sencibility_detail = ModelingSencibilityDetail.lumniStart(params,current_company, list: current_user.template('ModelingSencibilityDetail','modeling_sencibility_details',current_user))
		contactModelingSencibilityDetail = @modeling_sencibility_detail.lumniSave(params,current_user, list: current_user.template('ModelingSencibilityDetail','modeling_sencibility_details',current_user))
		lumniClose(@modeling_sencibility_detail,contactModelingSencibilityDetail)
	end
	def destroy
		@modeling_sencibility_detail = ModelingSencibilityDetail.lumniStart(params,current_company, list: current_user.template('ModelingSencibilityDetail','modeling_sencibility_details',current_user))
		contactModelingSencibilityDetail = @modeling_sencibility_detail.lumniSave(params,current_user, list: current_user.template('ModelingSencibilityDetail','modeling_sencibility_details',current_user))
		lumniClose(@cluster,contactModelingSencibilityDetail)
	end
end