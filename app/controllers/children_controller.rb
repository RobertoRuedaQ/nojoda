class ChildrenController < ApplicationController
	def index
		@child = Child.lumniStart(params,current_company, list: current_user.template('Child','children',current_user))
		contactChild = @child.lumniSave(params,current_user, list: current_user.template('Child','children',current_user))
		lumniClose(@child,contactChild)
	end

	def new
		@child = Child.lumniStart(params,current_company, list: current_user.template('Child','children',current_user))
		contactChild = @child.lumniSave(params,current_user, list: current_user.template('Child','children',current_user))
		lumniClose(@child,contactChild)
	end

	def create
		@child = Child.lumniStart(params,current_company, list: current_user.template('Child','children',current_user))
		contactChild = @child.lumniSave(params,current_user, list: current_user.template('Child','children',current_user))
		lumniClose(@child,contactChild)
	end

	def edit
		@child = Child.lumniStart(params,current_company, list: current_user.template('Child','children',current_user))
		contactChild = @child.lumniSave(params,current_user, list: current_user.template('Child','children',current_user))
		lumniClose(@child,contactChild)
	end

	def update
		@child = Child.lumniStart(params,current_company, list: current_user.template('Child','children',current_user))
		contactChild = @child.lumniSave(params,current_user, list: current_user.template('Child','children',current_user))
		lumniClose(@child,contactChild)
	end
	def destroy
		@child = Child.lumniStart(params,current_company, list: current_user.template('Child','children',current_user))
		contactChild = @child.lumniSave(params,current_user, list: current_user.template('Child','children',current_user))
		lumniClose(@cluster,contactChild)
	end

	def no_children_application
		@section = OriginationSection.cached_find(params[:section_id])
		@user = User.cached_find(params[:user_id])
	end

	def new_record
	end

	def create_application_child
		@section = OriginationSection.cached_find(params[:temp][:section])
		@application = Application.cached_find(params[:temp][:application_id])
		@child = Child.create(permit_application_params(@section.cached_form_template.child.template_hash( current_user, current_company)))
	end

	def edit_application_child
		@section = OriginationSection.cached_find(params[:section_id])
		@application = Application.cached_find(params[:application_id])
		@child = Child.cached_find(params[:id])
		@template = FormTemplate.cached_find(params[:template_id]).template_hash( current_user, current_company)
	end

	def update_application_child
		@section = OriginationSection.cached_find(params[:temp][:section])
		@application = Application.cached_find(params[:temp][:application_id])
		@child = Child.cached_find(params[:id])
		@child.update(permit_application_params(@section.cached_form_template.child.template_hash( current_user, current_company)))
	end

private
	def permit_application_params template
		params.require(:child).permit(template.keys)
	end

end