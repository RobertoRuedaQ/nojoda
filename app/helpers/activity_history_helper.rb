module ActivityHistoryHelper
	def display_history(target_object, options={})
		@target_object = target_object.audits
		@options = options
		render 'forms/activity_history'
	end
end
