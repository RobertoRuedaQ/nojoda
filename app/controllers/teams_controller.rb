class TeamsController < ApplicationController

	def index
		@user = User.lumniStart(params,current_company, list: current_user.template('Team','teams',current_user)).where(type_of_account: 'staff')
		userResult = @user.lumniSave(params,current_user, list: current_user.template('Team','teams',current_user))
		lumniClose(@user,userResult, list: current_user.template('Team','teams',current_user))
	end

	def new
		@user = User.lumniStart(params,current_company, list: current_user.template('Team','teams',current_user))
		userResult = @user.lumniSave(params,current_user, list: current_user.template('Team','teams',current_user))
		lumniClose(@user,userResult, list: current_user.template('Team','teams',current_user))
	end

	def create
		@user = User.lumniStart(params,current_company, list: current_user.template('Team','teams',current_user))
		@user.company = current_company
		@user.password = 'asdf1234'
#		@user.password = password_generator(10)
		@user.type_of_account = 'staff'
		userResult = @user.lumniSave(params,current_user)
		lumniClose(@user,userResult, list: current_user.template('Team','teams',current_user))
	end

	def update
		@user = User.lumniStart(params,current_company, list: current_user.template('Team','teams',current_user))

		if !params[:user].nil?
			userResult = @user.lumniSave(params,current_user,list: current_user.template('Team','teams',current_user))
		end

		if !params[:contactinfo].nil?
			if @user.contact_info.update_attributes(contact_info_params)
				flash[:success] = I18n.t('flash.record_updated')
				userResult = 'updated'
			end
		end

		lumniClose(@user,userResult, list: current_user.template('Team','teams',current_user))


		
	end


	def destroy
		@user = User.lumniStart(params,current_company)
		userResult = @user.lumniSave(params,current_user)
		lumniClose(@user,userResult)
	end


	def edit
		@user = User.lumniStart(params,current_company, list: current_user.template('Team','teams',current_user))
		userResult = @user.lumniSave(params,current_user, list: current_user.template('Team','teams',current_user))
		if @user.type_of_account != 'staff'
			userResult = 'unauthorized'
		end
		lumniClose(@user,userResult)
	end

	def simulate

		if !params[:simulate].nil?
			temp_account = current_user.id
		else
			temp_account = nil
		end
	    sign_in(:user, User.cached_find(params[:id]))
	    session[:original_account] = temp_account
	    redirect_to root_url # or user_root_url
	end

	private

	def password_generator size
		o = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten
		string = (0...size).map { o[rand(o.length)] }.join
	end

	def team_params
		params.require(:user).permit(clean_lists(teams_fields),:password)
	end
	def contact_info_params
		params.require(:contactinfo).permit(clean_lists(contact_infos_fields))
	end
end
