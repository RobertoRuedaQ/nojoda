class SociodemographicsController < ApplicationController
	def index
		@sociodemographic = Sociodemographic.lumniStart(params,current_company, list: current_user.template('Sociodemographic','sociodemographics',current_user))
		contactSociodemographic = @sociodemographic.lumniSave(params,current_user, list: current_user.template('Sociodemographic','sociodemographics',current_user))
		lumniClose(@sociodemographic,contactSociodemographic)
	end

	def new
		@sociodemographic = Sociodemographic.lumniStart(params,current_company, list: current_user.template('Sociodemographic','sociodemographics',current_user))
		contactSociodemographic = @sociodemographic.lumniSave(params,current_user, list: current_user.template('Sociodemographic','sociodemographics',current_user))
		lumniClose(@sociodemographic,contactSociodemographic)
	end

	def create
		@sociodemographic = Sociodemographic.lumniStart(params,current_company, list: current_user.template('Sociodemographic','sociodemographics',current_user))
		contactSociodemographic = @sociodemographic.lumniSave(params,current_user, list: current_user.template('Sociodemographic','sociodemographics',current_user))
		lumniClose(@sociodemographic,contactSociodemographic)
	end

	def edit
		@sociodemographic = Sociodemographic.lumniStart(params,current_company, list: current_user.template('Sociodemographic','sociodemographics',current_user))
		contactSociodemographic = @sociodemographic.lumniSave(params,current_user, list: current_user.template('Sociodemographic','sociodemographics',current_user))
		lumniClose(@sociodemographic,contactSociodemographic)
	end

	def update
		@sociodemographic = Sociodemographic.lumniStart(params,current_company, list: current_user.template('Sociodemographic','sociodemographics',current_user))
		contactSociodemographic = @sociodemographic.lumniSave(params,current_user, list: current_user.template('Sociodemographic','sociodemographics',current_user))
		lumniClose(@sociodemographic,contactSociodemographic)
	end
	def destroy
		@sociodemographic = Sociodemographic.lumniStart(params,current_company, list: current_user.template('Sociodemographic','sociodemographics',current_user))
		contactSociodemographic = @sociodemographic.lumniSave(params,current_user, list: current_user.template('Sociodemographic','sociodemographics',current_user))
		lumniClose(@cluster,contactSociodemographic)
	end
end