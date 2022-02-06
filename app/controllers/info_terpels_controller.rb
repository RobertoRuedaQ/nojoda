class InfoTerpelsController < ApplicationController
	def index
		@info_terpel = InfoTerpel.lumniStart(params,current_company, list: current_user.template('InfoTerpel','info_terpels',current_user))
		contactInfoTerpel = @info_terpel.lumniSave(params,current_user, list: current_user.template('InfoTerpel','info_terpels',current_user))
		lumniClose(@info_terpel,contactInfoTerpel)
	end

	def new
		@info_terpel = InfoTerpel.lumniStart(params,current_company, list: current_user.template('InfoTerpel','info_terpels',current_user))
		contactInfoTerpel = @info_terpel.lumniSave(params,current_user, list: current_user.template('InfoTerpel','info_terpels',current_user))
		lumniClose(@info_terpel,contactInfoTerpel)
	end

	def create
		@info_terpel = InfoTerpel.lumniStart(params,current_company, list: current_user.template('InfoTerpel','info_terpels',current_user))
		contactInfoTerpel = @info_terpel.lumniSave(params,current_user, list: current_user.template('InfoTerpel','info_terpels',current_user))
		lumniClose(@info_terpel,contactInfoTerpel)
	end

	def edit
		@info_terpel = InfoTerpel.lumniStart(params,current_company, list: current_user.template('InfoTerpel','info_terpels',current_user))
		contactInfoTerpel = @info_terpel.lumniSave(params,current_user, list: current_user.template('InfoTerpel','info_terpels',current_user))
		lumniClose(@info_terpel,contactInfoTerpel)
	end

	def update
		@info_terpel = InfoTerpel.lumniStart(params,current_company, list: current_user.template('InfoTerpel','info_terpels',current_user))
		contactInfoTerpel = @info_terpel.lumniSave(params,current_user, list: current_user.template('InfoTerpel','info_terpels',current_user))
		lumniClose(@info_terpel,contactInfoTerpel)
	end
	def destroy
		@info_terpel = InfoTerpel.lumniStart(params,current_company, list: current_user.template('InfoTerpel','info_terpels',current_user))
		contactInfoTerpel = @info_terpel.lumniSave(params,current_user, list: current_user.template('InfoTerpel','info_terpels',current_user))
		lumniClose(@cluster,contactInfoTerpel)
	end
end