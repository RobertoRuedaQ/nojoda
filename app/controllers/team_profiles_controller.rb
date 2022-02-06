class TeamProfilesController < ApplicationController
	def index
		@profile = TeamProfile.lumniStart(params,current_company)
		profileResult = @profile.lumniSave(params,current_user)
		lumniClose(@profile,profileResult)
	end

	def new
		@profile = TeamProfile.lumniStart(params,current_company)
		profileResult = @profile.lumniSave(params,current_user)
		lumniClose(@profile,profileResult)
	end

	def create
		@profile = TeamProfile.lumniStart(params,current_company)
		profileResult = @profile.lumniSave(params,current_user)
		lumniClose(@profile,profileResult)
	end

	def edit
		@profile = TeamProfile.lumniStart(params,current_company)
		profileResult = @profile.lumniSave(params,current_user)
		lumniClose(@profile,profileResult)
		@currentRoles = @profile.cached_role_names
		@profile.flush_cached_roles
		assign_templates
	end

	def update
		@profile = TeamProfile.lumniStart(params,current_company)
		profileResult = @profile.lumniSave(params,current_user)
		lumniClose(@profile,profileResult)
	end
	def destroy
		@profile = TeamProfile.lumniStart(params,current_company)
		profileResult = @profile.lumniSave(params,current_user)
		lumniClose(@profile,profileResult)
	end

	def assigning_roles
		exeptions = ['team_profiles_roles',]
		superUser = TeamProfile.find(1)
		controllerList = Rails.application.routes.routes.map do |route|
		  (!route.defaults[:controller].nil? && !route.defaults[:controller].include?('/')) ? route.defaults[:controller] : nil
		end.uniq.compact
		controllerList = controllerList - exeptions

		modelList = controllerList.map{|model| model.singularize.camelize}

		actionRoles = ['create','update','destroy','view']
		variationRoles = ['','_with_approval','_approver']


		modelList.each do |model|

			actionRoles.map{ |action| puts "superUser.add_role :#{action}, #{model}"}
			actionRoles.map{ |action| eval("superUser.add_role :#{action}, #{model}")}

		end

	end

	def assign_templates
		puts 'entrando a crear templates'
		current_templates = @profile.team_profile_template.kept
		controller_templates = current_templates.map{|t| t.controller_name}
		controllers_list.each do |controller|
			puts 'revisando template: ' + controller.to_s
			if !controller_templates.include?(controller)
				puts 'object: ' + controller.singularize.camelize
				targetTemplate = FormTemplate.where(object: controller.singularize.camelize,default: true).kept.first
				if !targetTemplate.nil?
					puts 'pasó segunda barrera'
					TeamProfileTemplate.create({team_profile_id: @profile.id,form_template_id: targetTemplate.id,controller_name: controller})
				end
			end
		end
	end

	def template_table
	end

	def role_table
		@profile = TeamProfile.cached_find(params[:id])
	end
end
