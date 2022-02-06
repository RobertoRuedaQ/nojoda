module CommunicationUsersHelper

	def create_mail_theme user_id
		@target_user = User.includes(:communication_user).find(user_id)
		render 'communication_users/partial/communications'
	end

	def loadUserMessageBody message_id
		@message = CommunicationUser.cached_find(message_id)
		render 'communication_users/partial/email_body'

	end

	def loadUserMessageHeader message_id
		@message = CommunicationUser.cached_find(message_id)
		render 'communication_users/partial/email_header'
	end
end
