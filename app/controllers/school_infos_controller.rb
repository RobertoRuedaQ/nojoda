class SchoolInfosController < ApplicationController
	def index
		@school_info = SchoolInfo.lumniStart(params,current_company, list: current_user.template('SchoolInfo','school_infos',current_user))
		contactSchoolInfo = @school_info.lumniSave(params,current_user, list: current_user.template('SchoolInfo','school_infos',current_user))
		lumniClose(@school_info,contactSchoolInfo)
	end

	def new
		@school_info = SchoolInfo.lumniStart(params,current_company, list: current_user.template('SchoolInfo','school_infos',current_user))
		contactSchoolInfo = @school_info.lumniSave(params,current_user, list: current_user.template('SchoolInfo','school_infos',current_user))
		lumniClose(@school_info,contactSchoolInfo)
	end

	def create
		@school_info = SchoolInfo.lumniStart(params,current_company, list: current_user.template('SchoolInfo','school_infos',current_user))
		contactSchoolInfo = @school_info.lumniSave(params,current_user, list: current_user.template('SchoolInfo','school_infos',current_user))
		lumniClose(@school_info,contactSchoolInfo)
	end

	def edit
		@school_info = SchoolInfo.lumniStart(params,current_company, list: current_user.template('SchoolInfo','school_infos',current_user))
		contactSchoolInfo = @school_info.lumniSave(params,current_user, list: current_user.template('SchoolInfo','school_infos',current_user))
		lumniClose(@school_info,contactSchoolInfo)
	end

	def update
		@school_info = SchoolInfo.lumniStart(params,current_company, list: current_user.template('SchoolInfo','school_infos',current_user))
		contactSchoolInfo = @school_info.lumniSave(params,current_user, list: current_user.template('SchoolInfo','school_infos',current_user))
		lumniClose(@school_info,contactSchoolInfo)
	end
	def destroy
		@school_info = SchoolInfo.lumniStart(params,current_company, list: current_user.template('SchoolInfo','school_infos',current_user))
		contactSchoolInfo = @school_info.lumniSave(params,current_user, list: current_user.template('SchoolInfo','school_infos',current_user))
		lumniClose(@cluster,contactSchoolInfo)
	end
end