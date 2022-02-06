class Role < ApplicationRecord
  resourcify
	has_and_belongs_to_many :team_profiles, :join_table => :team_profiles_roles
	has_one :team_approval, dependent: :destroy


	belongs_to :resource,
	           :polymorphic => true,
	           :optional => true


	validates :resource_type,
	          :inclusion => { :in => Rolify.resource_types },
	          :allow_nil => true

	scopify

	after_commit :flush_cache

	def approver_id
		TeamApproval.find_by_role_id(self.id).team_profile_id
	end

	def role_name
		(self.resource_type.nil? ? '' : find_controller_by_model(self.resource_type) )+ '_' + self.name
	end

	def flush_cache
		Rails.cache.clear
	end

end
