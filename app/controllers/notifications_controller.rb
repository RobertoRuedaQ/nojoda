class NotificationsController < ApplicationController
	def index
		@notification = Notification.lumniStart(params,current_company, list: current_user.template('Notification','notifications',current_user))
		contactNotification = @notification.lumniSave(params,current_user, list: current_user.template('Notification','notifications',current_user))
		lumniClose(@notification,contactNotification)
	end

	def new
		@notification = Notification.lumniStart(params,current_company, list: current_user.template('Notification','notifications',current_user))
		contactNotification = @notification.lumniSave(params,current_user, list: current_user.template('Notification','notifications',current_user))
		lumniClose(@notification,contactNotification)
	end

	def create
		@notification = Notification.lumniStart(params,current_company, list: current_user.template('Notification','notifications',current_user))
		contactNotification = @notification.lumniSave(params,current_user, list: current_user.template('Notification','notifications',current_user))
		lumniClose(@notification,contactNotification)
	end

	def edit
		@notification = Notification.lumniStart(params,current_company, list: current_user.template('Notification','notifications',current_user))
		contactNotification = @notification.lumniSave(params,current_user, list: current_user.template('Notification','notifications',current_user))
		lumniClose(@notification,contactNotification)
	end

	def update
		@notification = Notification.lumniStart(params,current_company, list: current_user.template('Notification','notifications',current_user))
		contactNotification = @notification.lumniSave(params,current_user, list: current_user.template('Notification','notifications',current_user))
		lumniClose(@notification,contactNotification)
	end
	def destroy
		@notification = Notification.lumniStart(params,current_company, list: current_user.template('Notification','notifications',current_user))
		contactNotification = @notification.lumniSave(params,current_user, list: current_user.template('Notification','notifications',current_user))
		lumniClose(@cluster,contactNotification)
	end

	def got_it
		@notification = Notification.cached_find(params[:id])
		@notification.update(got_it: true)
	end
end