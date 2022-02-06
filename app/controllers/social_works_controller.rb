class SocialWorksController < ApplicationController
	def index
		@social_work = SocialWork.lumniStart(params,current_company, list: current_user.template('SocialWork','social_works',current_user))
		contactSocialWork = @social_work.lumniSave(params,current_user, list: current_user.template('SocialWork','social_works',current_user))
		lumniClose(@social_work,contactSocialWork)
	end

	def new
		@social_work = SocialWork.lumniStart(params,current_company, list: current_user.template('SocialWork','social_works',current_user))
		contactSocialWork = @social_work.lumniSave(params,current_user, list: current_user.template('SocialWork','social_works',current_user))
		lumniClose(@social_work,contactSocialWork)
	end

	def create
		@social_work = SocialWork.lumniStart(params,current_company, list: current_user.template('SocialWork','social_works',current_user))
		contactSocialWork = @social_work.lumniSave(params,current_user, list: current_user.template('SocialWork','social_works',current_user))
		lumniClose(@social_work,contactSocialWork)
	end

	def edit
		@social_work = SocialWork.lumniStart(params,current_company, list: current_user.template('SocialWork','social_works',current_user))
		contactSocialWork = @social_work.lumniSave(params,current_user, list: current_user.template('SocialWork','social_works',current_user))
		lumniClose(@social_work,contactSocialWork)
	end

	def update
		@social_work = SocialWork.lumniStart(params,current_company, list: current_user.template('SocialWork','social_works',current_user))
		contactSocialWork = @social_work.lumniSave(params,current_user, list: current_user.template('SocialWork','social_works',current_user))
		lumniClose(@social_work,contactSocialWork)
	end
	def destroy
		@social_work = SocialWork.lumniStart(params,current_company, list: current_user.template('SocialWork','social_works',current_user))
		contactSocialWork = @social_work.lumniSave(params,current_user, list: current_user.template('SocialWork','social_works',current_user))
		lumniClose(@cluster,contactSocialWork)
	end
end