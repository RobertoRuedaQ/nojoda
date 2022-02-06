module FeedbacksHelper

	def feedback_category_color category
		case category
		when 'idea'
			result = 'success'
		when 'requirement'
			result = 'secondary'
		when 'suggestion'
			result = 'info'
		end
	end
end
