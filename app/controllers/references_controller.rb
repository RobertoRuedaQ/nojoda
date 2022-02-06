class ReferencesController < ApplicationController
	def index
		@reference = Reference.lumniStart(params,current_company, list: current_user.template('Reference','references',current_user))
		contactReference = @reference.lumniSave(params,current_user, list: current_user.template('Reference','references',current_user))
		lumniClose(@reference,contactReference)
	end

	def new
		@reference = Reference.lumniStart(params,current_company, list: current_user.template('Reference','references',current_user))
		contactReference = @reference.lumniSave(params,current_user, list: current_user.template('Reference','references',current_user))
		lumniClose(@reference,contactReference)
	end

	def create
		@reference = Reference.lumniStart(params,current_company, list: current_user.template('Reference','references',current_user))
		contactReference = @reference.lumniSave(params,current_user, list: current_user.template('Reference','references',current_user))
		lumniClose(@reference,contactReference)
	end

	def edit
		@reference = Reference.lumniStart(params,current_company, list: current_user.template('Reference','references',current_user))
		contactReference = @reference.lumniSave(params,current_user, list: current_user.template('Reference','references',current_user))
		lumniClose(@reference,contactReference)
	end

	def update
		@reference = Reference.lumniStart(params,current_company, list: current_user.template('Reference','references',current_user))
		contactReference = @reference.lumniSave(params,current_user, list: current_user.template('Reference','references',current_user))
		lumniClose(@reference,contactReference)
	end
	def destroy
		@reference = Reference.lumniStart(params,current_company, list: current_user.template('Reference','references',current_user))
		contactReference = @reference.lumniSave(params,current_user, list: current_user.template('Reference','references',current_user))
		lumniClose(@cluster,contactReference)
	end

	def new_record
	end

	def create_application_reference
		@section = OriginationSection.cached_find(params[:temp][:section])
		@application = Application.cached_find(params[:temp][:application_id])
		@reference = Reference.create(permit_application_params(@section.cached_form_template.child.template_hash( current_user, current_company)))
	end

	def edit_application_reference
		@section = OriginationSection.cached_find(params[:section_id])
		@application = Application.cached_find(params[:application_id])
		@reference = Reference.cached_find(params[:id])
		@template = FormTemplate.cached_find(params[:template_id]).template_hash( current_user, current_company)
	end

	def update_application_reference
		@section = OriginationSection.cached_find(params[:temp][:section])
		@application = Application.cached_find(params[:temp][:application_id])
		@reference = Reference.cached_find(params[:id])
		@reference.update(permit_application_params(@section.cached_form_template.child.template_hash( current_user, current_company)))
	end

	private
	def permit_application_params template
		params.require(:reference).permit(template.keys)
	end

end