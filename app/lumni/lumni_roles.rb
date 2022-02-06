module LumniRoles

	def destroy_role target_hash={}
		target_hash = eval(target_hash)
		role = target_hash['role'].to_sym
		model = eval(target_hash['model'].singularize.camelize)
		@profile = TeamProfile.cached_find(target_hash['profile_id'])
		idRole = @profile.role_id( role,model)
		TeamApproval.where(role_id: idRole).cached_destroy_all
		@profile.remove_role role, model
		@profile.flush_cached_roles
	end

	def create_role target_hash={}
		target_hash = eval(target_hash)

		role = target_hash['role'].to_sym
		model = eval(target_hash['model'].singularize.camelize)
		@profile = TeamProfile.cached_find(target_hash['profile_id'].to_i)
		@profile.add_role role, model
		@profile.flush_cached_roles
	end

end