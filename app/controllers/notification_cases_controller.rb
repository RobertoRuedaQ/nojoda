class NotificationCasesController < ApplicationController
	def index
		@notification_case = NotificationCase.lumniStart(params,current_company, list: current_user.template('NotificationCase','notification_cases',current_user))
		contactNotificationCase = @notification_case.lumniSave(params,current_user, list: current_user.template('NotificationCase','notification_cases',current_user))
		lumniClose(@notification_case,contactNotificationCase)
	end

	def new
		@notification_case = NotificationCase.lumniStart(params,current_company, list: current_user.template('NotificationCase','notification_cases',current_user))
		contactNotificationCase = @notification_case.lumniSave(params,current_user, list: current_user.template('NotificationCase','notification_cases',current_user))
		lumniClose(@notification_case,contactNotificationCase)
	end

	def create
		@notification_case = NotificationCase.lumniStart(params,current_company, list: current_user.template('NotificationCase','notification_cases',current_user))
		contactNotificationCase = @notification_case.lumniSave(params,current_user, list: current_user.template('NotificationCase','notification_cases',current_user))
		lumniClose(@notification_case,contactNotificationCase)
	end

	def edit
		@notification_case = NotificationCase.lumniStart(params,current_company, list: current_user.template('NotificationCase','notification_cases',current_user))
		contactNotificationCase = @notification_case.lumniSave(params,current_user, list: current_user.template('NotificationCase','notification_cases',current_user))
		lumniClose(@notification_case,contactNotificationCase)
	end

	def update
		@notification_case = NotificationCase.lumniStart(params,current_company, list: current_user.template('NotificationCase','notification_cases',current_user))
		contactNotificationCase = @notification_case.lumniSave(params,current_user, list: current_user.template('NotificationCase','notification_cases',current_user))
		lumniClose(@notification_case,contactNotificationCase)
	end
	def destroy
		@notification_case = NotificationCase.lumniStart(params,current_company, list: current_user.template('NotificationCase','notification_cases',current_user))
		contactNotificationCase = @notification_case.lumniSave(params,current_user, list: current_user.template('NotificationCase','notification_cases',current_user))
		lumniClose(@cluster,contactNotificationCase)
	end
end