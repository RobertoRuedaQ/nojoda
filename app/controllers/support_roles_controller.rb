class SupportRolesController < ApplicationController
	def index
		@support_role = SupportRole.lumniStart(params,current_company, list: current_user.template('SupportRole','support_roles',current_user))
		contactSupportRole = @support_role.lumniSave(params,current_user, list: current_user.template('SupportRole','support_roles',current_user))
		lumniClose(@support_role,contactSupportRole)
	end

	def new
		@support_role = SupportRole.lumniStart(params,current_company, list: current_user.template('SupportRole','support_roles',current_user))
		contactSupportRole = @support_role.lumniSave(params,current_user, list: current_user.template('SupportRole','support_roles',current_user))
		lumniClose(@support_role,contactSupportRole)
	end

	def create
		@support_role = SupportRole.lumniStart(params,current_company, list: current_user.template('SupportRole','support_roles',current_user))
		contactSupportRole = @support_role.lumniSave(params,current_user, list: current_user.template('SupportRole','support_roles',current_user))
		lumniClose(@support_role,contactSupportRole)
	end

	def edit
		@support_role = SupportRole.lumniStart(params,current_company, list: current_user.template('SupportRole','support_roles',current_user))
		contactSupportRole = @support_role.lumniSave(params,current_user, list: current_user.template('SupportRole','support_roles',current_user))
		lumniClose(@support_role,contactSupportRole)
	end

	def update
		@support_role = SupportRole.lumniStart(params,current_company, list: current_user.template('SupportRole','support_roles',current_user))
		contactSupportRole = @support_role.lumniSave(params,current_user, list: current_user.template('SupportRole','support_roles',current_user))
		lumniClose(@support_role,contactSupportRole)
	end
	def destroy
		@support_role = SupportRole.lumniStart(params,current_company, list: current_user.template('SupportRole','support_roles',current_user))
		contactSupportRole = @support_role.lumniSave(params,current_user, list: current_user.template('SupportRole','support_roles',current_user))
		lumniClose(@cluster,contactSupportRole)
	end
end