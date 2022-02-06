class ManageRolesAsync < ApplicationController
	include Sidekiq::Worker
	sidekiq_options queue: 'default'
	include LumniRoles

	def perform action, target_hash={}
		if action == 'create'
			create_role target_hash
		elsif action == 'destroy'
			destroy_role target_hash
		end
				
	end
end