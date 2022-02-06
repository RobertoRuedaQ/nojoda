class UniversityInfosController < ApplicationController
	def index
		@university_info = UniversityInfo.lumniStart(params,current_company, list: current_user.template('UniversityInfo','university_infos',current_user))
		contactUniversityInfo = @university_info.lumniSave(params,current_user, list: current_user.template('UniversityInfo','university_infos',current_user))
		lumniClose(@university_info,contactUniversityInfo)
	end

	def new
		@university_info = UniversityInfo.lumniStart(params,current_company, list: current_user.template('UniversityInfo','university_infos',current_user))
		contactUniversityInfo = @university_info.lumniSave(params,current_user, list: current_user.template('UniversityInfo','university_infos',current_user))
		lumniClose(@university_info,contactUniversityInfo)
	end

	def create
		@university_info = UniversityInfo.lumniStart(params,current_company, list: current_user.template('UniversityInfo','university_infos',current_user))
		contactUniversityInfo = @university_info.lumniSave(params,current_user, list: current_user.template('UniversityInfo','university_infos',current_user))
		lumniClose(@university_info,contactUniversityInfo)
	end

	def edit
		@university_info = UniversityInfo.lumniStart(params,current_company, list: current_user.template('UniversityInfo','university_infos',current_user))
		contactUniversityInfo = @university_info.lumniSave(params,current_user, list: current_user.template('UniversityInfo','university_infos',current_user))
		lumniClose(@university_info,contactUniversityInfo)
	end

	def update
		@university_info = UniversityInfo.lumniStart(params,current_company, list: current_user.template('UniversityInfo','university_infos',current_user))
		contactUniversityInfo = @university_info.lumniSave(params,current_user, list: current_user.template('UniversityInfo','university_infos',current_user))
		lumniClose(@university_info,contactUniversityInfo)
	end
	def destroy
		@university_info = UniversityInfo.lumniStart(params,current_company, list: current_user.template('UniversityInfo','university_infos',current_user))
		contactUniversityInfo = @university_info.lumniSave(params,current_user, list: current_user.template('UniversityInfo','university_infos',current_user))
		lumniClose(@cluster,contactUniversityInfo)
	end
end