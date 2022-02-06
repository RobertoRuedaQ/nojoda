class InstitutionsController < ApplicationController
	def index
		filtering = filter_interactor
		@ransack = filtering.ransack
		@institution = filtering.result.limit(1000)
		institutionResult = @institution.lumniSave(params,current_user)
		lumniClose(@institution,institutionResult)
	end

	def new
		@institution = Institution.lumniStart(params,current_company, list: current_user.template('Institution','institutions',current_user))
		institutionResult = @institution.lumniSave(params,current_user, list: current_user.template('Institution','institutions',current_user))
		lumniClose(@institution,institutionResult)
	end

	def create
		@institution = Institution.lumniStart(params,current_company, list: current_user.template('Institution','institutions',current_user))
		institutionResult = @institution.lumniSave(params,current_user, list: current_user.template('Institution','institutions',current_user))
		lumniClose(@institution,institutionResult)
	end

	def edit
		@institution = Institution.includes(:major, :location).lumniStart(params,current_company, list: current_user.template('Institution','institutions',current_user))
		institutionResult = @institution.lumniSave(params,current_user, list: current_user.template('Institution','institutions',current_user))
		lumniClose(@institution,institutionResult)
	end

	def update
		@institution = Institution.lumniStart(params,current_company, list: current_user.template('Institution','institutions',current_user))
		institutionResult = @institution.lumniSave(params,current_user, list: current_user.template('Institution','institutions',current_user))
		lumniClose(@institution,institutionResult)
	end

	def destroy
		@institution = Institution.lumniStart(params,current_company, list: current_user.template('Institution','institutions',current_user))
		institutionResult = @institution.lumniSave(params,current_user, list: current_user.template('Institution','institutions',current_user))
		lumniClose(@institution,institutionResult)
	end

	def set_major
		@institution_id = params[:institution]
		@major = params[:major_class]
		@model = params[:model]
		@field = params[:field]
		@form_key = params[:form_key]
		@options = eval(params[:options])
		@options[:id] = @institution_id.split('_').last
		params[:list_number] = nil if params[:list_number] == 'undefined'
		@options[:list] = programs_by_institution(params[:institution],params[:list_number])
		@options[:form_key] = @form_key
		@config = eval(params[:config])
	end

	private

	def filter_interactor
		FilterInteractor.call(
			resource: Institution.lumniStart(params, current_company),
			params: params
		)
	end
end

