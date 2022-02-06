module LumniApproval
	def request_user_name
		self.request_user.name
	end
	def respond_user_name
		self.respond_user.name if !self.respond_user_id.nil?
	end
	def approval_target
		self.items.first.resource_type
	end

	def approval_action
		self.items.first.event
	end
end