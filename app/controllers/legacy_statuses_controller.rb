class LegacyStatusesController < ApplicationController
	def index
		@legacy_status = LegacyStatus.lumniStart(params,current_company, list: current_user.template('LegacyStatus','legacy_statuses',current_user))
		contactLegacyStatus = @legacy_status.lumniSave(params,current_user, list: current_user.template('LegacyStatus','legacy_statuses',current_user))
		lumniClose(@legacy_status,contactLegacyStatus)
	end

	def new
		@legacy_status = LegacyStatus.lumniStart(params,current_company, list: current_user.template('LegacyStatus','legacy_statuses',current_user))
		contactLegacyStatus = @legacy_status.lumniSave(params,current_user, list: current_user.template('LegacyStatus','legacy_statuses',current_user))
		lumniClose(@legacy_status,contactLegacyStatus)
	end

	def create
		@legacy_status = LegacyStatus.lumniStart(params,current_company, list: current_user.template('LegacyStatus','legacy_statuses',current_user))
		contactLegacyStatus = @legacy_status.lumniSave(params,current_user, list: current_user.template('LegacyStatus','legacy_statuses',current_user))
		lumniClose(@legacy_status,contactLegacyStatus)
	end

	def edit
		@legacy_status = LegacyStatus.lumniStart(params,current_company, list: current_user.template('LegacyStatus','legacy_statuses',current_user))
		contactLegacyStatus = @legacy_status.lumniSave(params,current_user, list: current_user.template('LegacyStatus','legacy_statuses',current_user))
		lumniClose(@legacy_status,contactLegacyStatus)
	end

	def update
		@legacy_status = LegacyStatus.lumniStart(params,current_company, list: current_user.template('LegacyStatus','legacy_statuses',current_user))
		contactLegacyStatus = @legacy_status.lumniSave(params,current_user, list: current_user.template('LegacyStatus','legacy_statuses',current_user))
		lumniClose(@legacy_status,contactLegacyStatus)
	end
	def destroy
		@legacy_status = LegacyStatus.lumniStart(params,current_company, list: current_user.template('LegacyStatus','legacy_statuses',current_user))
		contactLegacyStatus = @legacy_status.lumniSave(params,current_user, list: current_user.template('LegacyStatus','legacy_statuses',current_user))
		lumniClose(@cluster,contactLegacyStatus)
	end
end