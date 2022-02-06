module NotificationCasesHelper
	def taskNotification notification
		task = ProjectTask.cached_find(notification.resource_id)
		render 'notification_cases/partial/new_task', task: task, notification: notification
	end
end
