class ContactInfosController < ApplicationController

	def index
		@contact_info = ContactInfo.lumniStart(params,current_company, list: current_user.template('ContactInfo','contact_infos',current_user))
		contactInfoResult = @contact_info.lumniSave(params,current_user, list: current_user.template('ContactInfo','contact_infos',current_user))
		lumniClose(@contact_info,contactInfoResult)
	end

	def new
		@contact_info = ContactInfo.lumniStart(params,current_company, list: current_user.template('ContactInfo','contact_infos',current_user))
		contactInfoResult = @contact_info.lumniSave(params,current_user, list: current_user.template('ContactInfo','contact_infos',current_user))
		lumniClose(@contact_info,contactInfoResult)
	end

	def create
		@contact_info = ContactInfo.lumniStart(params,current_company, list: current_user.template('ContactInfo','contact_infos',current_user))
		contactInfoResult = @contact_info.lumniSave(params,current_user, list: current_user.template('ContactInfo','contact_infos',current_user))
		lumniClose(@contact_info,contactInfoResult)
	end

	def edit
		@contact_info = ContactInfo.lumniStart(params,current_company, list: current_user.template('ContactInfo','contact_infos',current_user))
		contactInfoResult = @contact_info.lumniSave(params,current_user, list: current_user.template('ContactInfo','contact_infos',current_user))
		lumniClose(@contact_info,contactInfoResult)
	end

	def update
		@contact_info = ContactInfo.lumniStart(params,current_company, list: current_user.template('ContactInfo','contact_infos',current_user))
		contactInfoResult = @contact_info.lumniSave(params,current_user, list: current_user.template('ContactInfo','contact_infos',current_user))
		lumniClose(@contact_info,contactInfoResult)
	end
	def destroy
		@contact_info = ContactInfo.lumniStart(params,current_company, list: current_user.template('ContactInfo','contact_infos',current_user))
		contactInfoResult = @contact_info.lumniSave(params,current_user, list: current_user.template('ContactInfo','contact_infos',current_user))
		lumniClose(@cluster,contactInfoResult)
	end


	def create_application
    application = Application.joins(user: :contact_info).where(application_case: 'contact_info', status: 'active').where(contact_infos: {resource_type: "User", resource_id: current_user.id}).first
    if application.nil?
      @contact_info = ContactInfo.where(resource_type: "User", resource_id: current_user.id).first
      application = Application.new({status: 'active',user_id: current_user.id,application_case: 'contact_info',resource_type: 'ContactInfo', resource_id: @contact_info.id})
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
