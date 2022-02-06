class AcademiOriginationsController < ApplicationController
	def index
		@academi_origination = AcademiOrigination.lumniStart(params,current_company, list: current_user.template('AcademiOrigination','academi_originations',current_user))
		contactAcademiOrigination = @academi_origination.lumniSave(params,current_user, list: current_user.template('AcademiOrigination','academi_originations',current_user))
		lumniClose(@academi_origination,contactAcademiOrigination)
	end

	def new
		@academi_origination = AcademiOrigination.lumniStart(params,current_company, list: current_user.template('AcademiOrigination','academi_originations',current_user))
		contactAcademiOrigination = @academi_origination.lumniSave(params,current_user, list: current_user.template('AcademiOrigination','academi_originations',current_user))
		lumniClose(@academi_origination,contactAcademiOrigination)
	end

	def create
		@academi_origination = AcademiOrigination.lumniStart(params,current_company, list: current_user.template('AcademiOrigination','academi_originations',current_user))
		contactAcademiOrigination = @academi_origination.lumniSave(params,current_user, list: current_user.template('AcademiOrigination','academi_originations',current_user))
		lumniClose(@academi_origination,contactAcademiOrigination)
	end

	def edit
		@academi_origination = AcademiOrigination.lumniStart(params,current_company, list: current_user.template('AcademiOrigination','academi_originations',current_user))
		contactAcademiOrigination = @academi_origination.lumniSave(params,current_user, list: current_user.template('AcademiOrigination','academi_originations',current_user))
		lumniClose(@academi_origination,contactAcademiOrigination)
	end

	def update
		@academi_origination = AcademiOrigination.lumniStart(params,current_company, list: current_user.template('AcademiOrigination','academi_originations',current_user))
		contactAcademiOrigination = @academi_origination.lumniSave(params,current_user, list: current_user.template('AcademiOrigination','academi_originations',current_user))
		lumniClose(@academi_origination,contactAcademiOrigination)
	end
	def destroy
		@academi_origination = AcademiOrigination.lumniStart(params,current_company, list: current_user.template('AcademiOrigination','academi_originations',current_user))
		contactAcademiOrigination = @academi_origination.lumniSave(params,current_user, list: current_user.template('AcademiOrigination','academi_originations',current_user))
		lumniClose(@cluster,contactAcademiOrigination)
	end
end