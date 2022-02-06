class PersonalInformationsController < ApplicationController
	def index
		@personal_information = PersonalInformation.lumniStart(params,current_company)
		personalInformationResult = @personal_information.lumniSave(params,current_user)
		lumniClose(@personal_information,personalInformationResult)
	end

	def new
		@personal_information = PersonalInformation.lumniStart(params,current_company)
		personalInformationResult = @personal_information.lumniSave(params,current_user)
		lumniClose(@personal_information,personalInformationResult)
	end

	def create
		@personal_information = PersonalInformation.lumniStart(params,current_company)
		personalInformationResult = @personal_information.lumniSave(params,current_user)
		lumniClose(@personal_information,personalInformationResult)
	end

	def edit
		@personal_information = PersonalInformation.lumniStart(params,current_company)
		personalInformationResult = @personal_information.lumniSave(params,current_user)
		lumniClose(@personal_information,personalInformationResult)
	end

	def update
		@personal_information = PersonalInformation.lumniStart(params,current_company)
		personalInformationResult = @personal_information.lumniSave(params,current_user)
		lumniClose(@personal_information,personalInformationResult)
	end
	def destroy
		@personal_information = PersonalInformation.lumniStart(params,current_company)
		personalInformationResult = @personal_information.lumniSave(params,current_user)
		lumniClose(@personal_information,personalInformationResult)
	end


	def create_application
    application = Application.joins(user: :personal_information).where(application_case: 'personal_information', status: 'active').where(personal_informations: {user_id: current_user.id}).first
    if application.nil?
      @personal_information = PersonalInformation.find_by(user_id: current_user.id)
      application = Application.new({status: 'active',user_id: current_user.id,application_case: 'personal_information',resource_type: 'PersonalInformation', resource_id: @personal_information.id})
      if application.save
        redirect_to edit_application_path(application)
      else
        redirect_to root_path
      end
    else
      redirect_to edit_application_path(application)
    end
  end
end
