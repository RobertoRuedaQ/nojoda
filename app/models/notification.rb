class Notification < ApplicationRecord
      
    resourcify
  	belongs_to :notification_case
	belongs_to :resource, polymorphic: true
	belongs_to :user

	after_commit :flush_user_notifications

	def flush_user_notifications
		Rails.cache.delete(['notifications_count',self.user_id])
		Rails.cache.delete(['pending_notifications',self.user_id])
	end
end
