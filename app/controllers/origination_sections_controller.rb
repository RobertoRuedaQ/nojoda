class OriginationSectionsController < ApplicationController
	def index
		@origination_section = OriginationSection.lumniStart(params,current_company, list: current_user.template('OriginationSection','origination_sections',current_user))
		contactOriginationSection = @origination_section.lumniSave(params,current_user, list: current_user.template('OriginationSection','origination_sections',current_user))
		lumniClose(@origination_section,contactOriginationSection)
	end

	def new
		@origination_module = OriginationModule.cached_find(params[:id])
		set_template

		@origination_section = OriginationSection.lumniStart(params,current_company, list: @target_template)
		contactOriginationSection = @origination_section.lumniSave(params,current_user, list: @target_template)
		lumniClose(@origination_section,contactOriginationSection)

		case @origination_module.option
		when 'form'
			@resource_type = FormTemplate
		when 'questionnaire','stop_to_check','scoring'
			@resource_type = Questionnaire
		when 'legal_document'
			@resource_type = LegalDocument
		end
	end

	def create
		@origination_module = OriginationModule.cached_find(params[:originationsection][:origination_module_id])
		set_template


		@origination_section = OriginationSection.lumniStart(params,current_company, list: @target_template)
		contactOriginationSection = @origination_section.lumniSave(params,current_user, list: @target_template)
		lumniClose(@origination_section,contactOriginationSection)
	end

	def edit
		@origination_section = OriginationSection.lumniStart(params,current_company, list: @target_template)

		@origination_module = OriginationModule.cached_find(@origination_section.origination_module_id)
		set_template

		contactOriginationSection = @origination_section.lumniSave(params,current_user, list: @target_template)
		lumniClose(@origination_section,contactOriginationSection)
	end

	def update
		@origination_section = OriginationSection.lumniStart(params,current_company, list: @target_template)

		@origination_module = OriginationModule.cached_find(@origination_section.origination_module_id)
		set_template

		contactOriginationSection = @origination_section.lumniSave(params,current_user, list: @target_template)
		lumniClose(@origination_section,contactOriginationSection)
	end
	def destroy
		@origination_section = OriginationSection.lumniStart(params,current_company, list: @target_template)

		@origination_module = OriginationModule.cached_find(@origination_section.origination_module_id)
		set_template

		contactOriginationSection = @origination_section.lumniSave(params,current_user, list: @target_template)
		lumniClose(@cluster,contactOriginationSection)
	end

	def set_template
		temp_template = FormTemplate.where(child_foreign_key: @origination_module.option,object: "OriginationSection").first
		puts "this is the template id: #{temp_template.id}"
		@target_template = temp_template.template_hash( current_user,current_company)
	end
end