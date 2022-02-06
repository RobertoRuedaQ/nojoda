class ActivitiesDetailsController < ApplicationController
	def index
		@activities_detail = ActivitiesDetail.lumniStart(params,current_company, list: current_user.template('ActivitiesDetail','activities_details',current_user))
		contactActivitiesDetail = @activities_detail.lumniSave(params,current_user, list: current_user.template('ActivitiesDetail','activities_details',current_user))
		lumniClose(@activities_detail,contactActivitiesDetail)
	end

	def new
		if !params[:user_id].nil?
			@activities_detail = ActivitiesDetail.lumniStart(params,current_company, list: current_user.template('ActivitiesDetail','activities_details',current_user))
			@activities_detail.user_id = params[:user_id]
			contactActivitiesDetail = @activities_detail.lumniSave(params,current_user, list: current_user.template('ActivitiesDetail','activities_details',current_user))
			lumniClose(@activities_detail,contactActivitiesDetail)
		else
			redirect_to root_path
		end
	end

	def create
		@activities_detail = ActivitiesDetail.lumniStart(params,current_company, list: current_user.template('ActivitiesDetail','activities_details',current_user))
		contactActivitiesDetail = @activities_detail.lumniSave(params,current_user, list: current_user.template('ActivitiesDetail','activities_details',current_user))
		lumniClose(@activities_detail,contactActivitiesDetail)
	end

	def edit
		@activities_detail = ActivitiesDetail.lumniStart(params,current_company, list: current_user.template('ActivitiesDetail','activities_details',current_user))
		contactActivitiesDetail = @activities_detail.lumniSave(params,current_user, list: current_user.template('ActivitiesDetail','activities_details',current_user))
		lumniClose(@activities_detail,contactActivitiesDetail)
	end

	def update
		@activities_detail = ActivitiesDetail.lumniStart(params,current_company, list: current_user.template('ActivitiesDetail','activities_details',current_user))
		contactActivitiesDetail = @activities_detail.lumniSave(params,current_user, list: current_user.template('ActivitiesDetail','activities_details',current_user))
		lumniClose(@activities_detail,contactActivitiesDetail)
	end
	def destroy
		@activities_detail = ActivitiesDetail.lumniStart(params,current_company, list: current_user.template('ActivitiesDetail','activities_details',current_user))
		contactActivitiesDetail = @activities_detail.lumniSave(params,current_user, list: current_user.template('ActivitiesDetail','activities_details',current_user))
		lumniClose(@cluster,contactActivitiesDetail)
	end
end