module ProjectTaskTranslatesHelper
	def task_priority_color value
		case value
		when 'low'
			'text-info'
		when 'medium'
			'text-warning'
		when 'high'
			'text-danger'
		end
	end


	def task_type_icon value
		case value
		when 'mistakes'
			'ion ion-ios-bug'
		when 'suggestion'
			'ion ion-ios-bulb'
		when 'request'
			'ion ion-md-construct'
		end
	end
end
