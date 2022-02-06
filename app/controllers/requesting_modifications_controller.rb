class RequestingModificationsController < ApplicationController
	def index
		@requesting_modification = RequestingModification.lumniStart(params,current_company, list: current_user.template('RequestingModification','requesting_modifications',current_user))
		contactRequestingModification = @requesting_modification.lumniSave(params,current_user, list: current_user.template('RequestingModification','requesting_modifications',current_user))
		lumniClose(@requesting_modification,contactRequestingModification)
	end

	def new
		@requesting_modification = RequestingModification.lumniStart(params,current_company, list: current_user.template('RequestingModification','requesting_modifications',current_user))
		contactRequestingModification = @requesting_modification.lumniSave(params,current_user, list: current_user.template('RequestingModification','requesting_modifications',current_user))
		lumniClose(@requesting_modification,contactRequestingModification)
	end

	def create
		@requesting_modification = RequestingModification.lumniStart(params,current_company, list: current_user.template('RequestingModification','requesting_modifications',current_user))
		contactRequestingModification = @requesting_modification.lumniSave(params,current_user, list: current_user.template('RequestingModification','requesting_modifications',current_user))
		lumniClose(@requesting_modification,contactRequestingModification)
	end

	def edit
		@requesting_modification = RequestingModification.lumniStart(params,current_company, list: current_user.template('RequestingModification','requesting_modifications',current_user))
		contactRequestingModification = @requesting_modification.lumniSave(params,current_user, list: current_user.template('RequestingModification','requesting_modifications',current_user))
		lumniClose(@requesting_modification,contactRequestingModification)
	end

	def update
		@requesting_modification = RequestingModification.lumniStart(params,current_company, list: current_user.template('RequestingModification','requesting_modifications',current_user))
		contactRequestingModification = @requesting_modification.lumniSave(params,current_user, list: current_user.template('RequestingModification','requesting_modifications',current_user))
		lumniClose(@requesting_modification,contactRequestingModification)
	end
	def destroy
		@requesting_modification = RequestingModification.lumniStart(params,current_company, list: current_user.template('RequestingModification','requesting_modifications',current_user))
		contactRequestingModification = @requesting_modification.lumniSave(params,current_user, list: current_user.template('RequestingModification','requesting_modifications',current_user))
		lumniClose(@cluster,contactRequestingModification)
	end
end