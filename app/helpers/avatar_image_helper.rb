module AvatarImageHelper
	 

	def loadingAvatar size, options = {}
		if( params[:controller] == 'profiles')
			@target_user = current_user
			@stage = 1
		else
			tempId = options[:id].nil? ? params[:id] : options[:id]
			@target_user = User.includes([:avatar_attachment]).cached_find(tempId)
			@stage = 2
		end
		@avatarSize = size
		render '/forms/avatar'
	end

end