class ModelClassesAsync < ApplicationController
	include Sidekiq::Worker
	include LumniMigration
	include LumniRoles

	sidekiq_options queue: 'heavy_work'

	def perform model_name, target_method, target_id, opt={}
		begin
			eval("#{model_name}.find(#{target_id}).#{target_method}")
		rescue ActiveRecord::RecordNotFound => e
			puts e
		end
	end
end