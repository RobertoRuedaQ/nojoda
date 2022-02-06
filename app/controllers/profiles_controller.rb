class ProfilesController < ApplicationController

	def index
		@profile = current_user
		profileResult = @profile.lumniSave(params,current_user, list: current_user.template('Profile','profiles',current_user),model: 'Profile')
		lumniClose(@profile,profileResult)
	end

	def new
		@profile = current_user
		profileResult = @profile.lumniSave(params,current_user, list: current_user.template('Profile','profiles',current_user),model: 'Profile')
		lumniClose(@profile,profileResult)
	end

	def create
		@profile = current_user
		profileResult = @profile.lumniSave(params,current_user, list: current_user.template('Profile','profiles',current_user),model: 'Profile')
		lumniClose(@profile,profileResult)
	end

	def edit
		@profile = current_user
		@personal_information_application = Application.joins(user: :personal_information).where(application_case: 'personal_information', status: ['active','submitted']).where(personal_informations: {user_id: current_user.id}).first
		@contact_info_application = Application.joins(user: :contact_info).where(application_case: 'contact_info', status: ['active','submitted']).where(contact_infos: {resource_type: "User", resource_id: current_user.id}).first
		@location_application = Application.joins(user: :location).where(application_case: 'student_location', status: ['active','submitted']).where(locations: {resource_id: current_user.id, resource_type: 'User'}).first
		@student_application = Application.where(application_case: 'students_data', status: ['active','submitted']).where(user_id: current_user.id).first
		profileResult = @profile.lumniSave(params,current_user, list: current_user.template('Profile','profiles',current_user),model: 'Profile')
		lumniClose(@profile,profileResult)
	end

	def update
		@profile = current_user
		if params[:image].present?
			@profile.avatar = params[:image]
			@profile.flush_avatar
		end
		profileResult = @profile.lumniSave(params,current_user, list: current_user.template('Profile','profiles',current_user),model: 'Profile')
		lumniClose(@profile,profileResult)
	end
	def destroy
		@profile = current_user
		profileResult = @profile.lumniSave(params,current_user, list: current_user.template('Profile','profiles',current_user),model: 'Profile')
		lumniClose(@cluster,profileResult)
	end

end
