class OriginationModulesController < ApplicationController
	layout false, only: :edit
	def index
		@origination_module = OriginationModule.lumniStart(params,current_company, list: current_user.template('OriginationModule','origination_modules',current_user))
		contactOriginationModule = @origination_module.lumniSave(params,current_user, list: current_user.template('OriginationModule','origination_modules',current_user))
		lumniClose(@origination_module,contactOriginationModule)
	end

	def new
		@origination_module = OriginationModule.lumniStart(params,current_company, list: current_user.template('OriginationModule','origination_modules',current_user))
		contactOriginationModule = @origination_module.lumniSave(params,current_user, list: current_user.template('OriginationModule','origination_modules',current_user))
		lumniClose(@origination_module,contactOriginationModule)
	end

	def create
		@origination_module = OriginationModule.lumniStart(params,current_company, list: current_user.template('OriginationModule','origination_modules',current_user))
		contactOriginationModule = @origination_module.lumniSave(params,current_user, list: current_user.template('OriginationModule','origination_modules',current_user))
		lumniClose(@origination_module,contactOriginationModule)
		@origination = @origination_module.origination
	end

	def edit
		@origination_module = OriginationModule.lumniStart(params,current_company, list: current_user.template('OriginationModule','origination_modules',current_user))

		@origination = @origination_module.origination

		contactOriginationModule = @origination_module.lumniSave(params,current_user, list: current_user.template('OriginationModule','origination_modules',current_user))
		lumniClose(@origination_module,contactOriginationModule)
	end

	def update
		@origination_module = OriginationModule.lumniStart(params,current_company, list: current_user.template('OriginationModule','origination_modules',current_user))

		@origination = @origination_module.origination

		contactOriginationModule = @origination_module.lumniSave(params,current_user, list: current_user.template('OriginationModule','origination_modules',current_user))
		lumniClose(@origination_module,contactOriginationModule)
	end
	def destroy
		@origination_module = OriginationModule.lumniStart(params,current_company, list: current_user.template('OriginationModule','origination_modules',current_user))

		@origination = @origination_module.origination

		contactOriginationModule = @origination_module.lumniSave(params,current_user, list: current_user.template('OriginationModule','origination_modules',current_user))
		lumniClose(@cluster,contactOriginationModule)
	end

end