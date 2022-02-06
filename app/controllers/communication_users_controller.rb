class CommunicationUsersController < ApplicationController
	def index
		@communication_user = CommunicationUser.lumniStart(params,current_company, list: current_user.template('CommunicationUser','communication_users',current_user))
		contactCommunicationUser = @communication_user.lumniSave(params,current_user, list: current_user.template('CommunicationUser','communication_users',current_user))
		lumniClose(@communication_user,contactCommunicationUser)
	end

	def new
		@communication_user = CommunicationUser.lumniStart(params,current_company, list: current_user.template('CommunicationUser','communication_users',current_user))
		contactCommunicationUser = @communication_user.lumniSave(params,current_user, list: current_user.template('CommunicationUser','communication_users',current_user))
		lumniClose(@communication_user,contactCommunicationUser)
	end

	def create
		@communication_user = CommunicationUser.lumniStart(params,current_company, list: current_user.template('CommunicationUser','communication_users',current_user))
		contactCommunicationUser = @communication_user.lumniSave(params,current_user, list: current_user.template('CommunicationUser','communication_users',current_user))
		lumniClose(@communication_user,contactCommunicationUser)
	end

	def edit
		@communication_user = CommunicationUser.lumniStart(params,current_company, list: current_user.template('CommunicationUser','communication_users',current_user))
		contactCommunicationUser = @communication_user.lumniSave(params,current_user, list: current_user.template('CommunicationUser','communication_users',current_user))
		lumniClose(@communication_user,contactCommunicationUser)
	end

	def update
		@communication_user = CommunicationUser.lumniStart(params,current_company, list: current_user.template('CommunicationUser','communication_users',current_user))
		contactCommunicationUser = @communication_user.lumniSave(params,current_user, list: current_user.template('CommunicationUser','communication_users',current_user))
		lumniClose(@communication_user,contactCommunicationUser)
	end
	def destroy
		@communication_user = CommunicationUser.lumniStart(params,current_company, list: current_user.template('CommunicationUser','communication_users',current_user))
		contactCommunicationUser = @communication_user.lumniSave(params,current_user, list: current_user.template('CommunicationUser','communication_users',current_user))
		lumniClose(@cluster,contactCommunicationUser)
	end

	def load_message
	end
end