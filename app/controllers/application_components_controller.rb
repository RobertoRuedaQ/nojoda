class ApplicationComponentsController < ApplicationController
	def index
		@application_component = ApplicationComponent.lumniStart(params,current_company)
		applicationComponentResult = @application_component.lumniSave(params,current_user)
		lumniClose(@application_component,applicationComponentResult)
	end

	def new
		@application_component = ApplicationComponent.lumniStart(params,current_company)
		applicationComponentResult = @application_component.lumniSave(params,current_user)
		lumniClose(@application_component,applicationComponentResult)
	end

	def create
		@application_component = ApplicationComponent.lumniStart(params,current_company)
		applicationComponentResult = @application_component.lumniSave(params,current_user)
		lumniClose(@application_component,applicationComponentResult)
	end

	def edit
		@application_component = ApplicationComponent.lumniStart(params,current_company)
		applicationComponentResult = @application_component.lumniSave(params,current_user)
		lumniClose(@application_component,applicationComponentResult)
	end

	def update
		@application_component = ApplicationComponent.lumniStart(params,current_company)
		applicationComponentResult = @application_component.lumniSave(params,current_user)
		lumniClose(@application_component,applicationComponentResult)
	end
	def destroy
		@application_component = ApplicationComponent.lumniStart(params,current_company)
		applicationComponentResult = @application_component.lumniSave(params,current_user)
		lumniClose(@application_component,applicationComponentResult)
	end

end
