class LocationsController < ApplicationController
	def index
		@location = Location.lumniStart(params,current_company)
		locationResult = @location.lumniSave(params,current_user)
		lumniClose(@location,locationResult)
	end

	def new
		@location = Location.lumniStart(params,current_company)
		locationResult = @location.lumniSave(params,current_user)
		lumniClose(@location,locationResult)
	end

	def create
		@location = Location.lumniStart(params,current_company)
		locationResult = @location.lumniSave(params,current_user)
		lumniClose(@location,locationResult)
	end

	def edit
		@location = Location.lumniStart(params,current_company)
		locationResult = @location.lumniSave(params,current_user)
		lumniClose(@location,locationResult)
	end

	def update
		@location = Location.lumniStart(params,current_company)
		locationResult = @location.lumniSave(params,current_user)
		lumniClose(@location,locationResult)
	end
	def destroy
		@location = Location.lumniStart(params,current_company)
		locationResult = @location.lumniSave(params,current_user)
		lumniClose(@cluster,locationResult)
	end

	def regions
		clean_params
	end
	def cities
		clean_params
	end

	def clean_params
		@country = params[:country_class]
		@region = params[:region_class]
		@city = params[:city_class]
		@model = params[:model]
		@field = params[:field]
		@form_key = params[:form_key]
		@options = eval(params[:options])
		if !@options[:list].nil?
			@options[:filter_list] = @options[:list].values.first[:values]
		end
		@options[:id] = @region.split('_').last
		@options[:list] = regionsCitiesList(params[:country],params[:region],@options)
		@options[:form_key] = @form_key
		@config = eval(params[:config])

	end


	def create_application
    application = Application.joins(user: :location).where(application_case: 'student_location', status: 'active').where(locations: {resource_id: current_user.id, resource_type: 'User'}).first
    if application.nil?
      @location = Location.find_or_create_by(resource_id: current_user.id, resource_type: "User")
      application = Application.new({status: 'active',user_id: current_user.id,application_case: 'student_location',resource_type: 'Location', resource_id: @location.id})
      if application.save
        redirect_to edit_application_path(application)
      else
        redirect_to root_path
      end
    else
      redirect_to edit_application_path(application)
    end
  end
end
