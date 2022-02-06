## The options are controller plus:
# update
# create
# destroy
# update_with_approval
# create_with_approval
# destroy_with_approval
# update_approver
# create_approver
# destroy_approver

class RolesController < ApplicationController
	def index
		@role = Role.lumniStart(params,current_company)
		roleResult = @role.lumniSave(params,current_user)
		lumniClose(@role,roleResult)
	end

	def new
		@role = Role.lumniStart(params,current_company)
		roleResult = @role.lumniSave(params,current_user)
		lumniClose(@role,roleResult)
	end

	def create
		@role = Role.lumniStart(params,current_company)
		roleResult = @role.lumniSave(params,current_user)
		lumniClose(@role,roleResult)
	end

	def edit
		@role = Role.lumniStart(params,current_company)
		roleResult = @role.lumniSave(params,current_user)
		lumniClose(@role,roleResult)
	end

	def update
		@role = Role.lumniStart(params,current_company)
		roleResult = @role.lumniSave(params,current_user)
		lumniClose(@role,roleResult)
	end
	def destroy
		@role = Role.lumniStart(params,current_company)
		roleResult = @role.lumniSave(params,current_user)
		lumniClose(@role,roleResult)
	end

	def destroy_role
		ManageRolesAsync.perform_async 'destroy',params
	end

	def create_role
		ManageRolesAsync.perform_async('create',params)
	end

	def asign_approver
		@profile = TeamProfile.cached_find(params[:profile_id].to_i)
		@approver = TeamApproval.create({team_profile_id: params[:approver].to_i,role_id: @profile.role_id(params[:role],params[:model])})
	end



end
