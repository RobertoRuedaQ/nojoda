class IsasController < ApplicationController
	def index
		@isa = Isa.lumniStart(params,current_company, list: current_user.template('Isa','isas',current_user))
		contactIsa = @isa.lumniSave(params,current_user, list: current_user.template('Isa','isas',current_user))
		lumniClose(@isa,contactIsa)
	end

	def new
		@isa = Isa.lumniStart(params,current_company, list: current_user.template('Isa','isas',current_user))
		contactIsa = @isa.lumniSave(params,current_user, list: current_user.template('Isa','isas',current_user))
		lumniClose(@isa,contactIsa)
	end

	def create
		@isa = Isa.lumniStart(params,current_company, list: current_user.template('Isa','isas',current_user))
		contactIsa = @isa.lumniSave(params,current_user, list: current_user.template('Isa','isas',current_user))
		lumniClose(@isa,contactIsa)
	end

	def edit
		@isa = Isa.lumniStart(params,current_company, list: current_user.template('Isa','isas',current_user))
		contactIsa = @isa.lumniSave(params,current_user, list: current_user.template('Isa','isas',current_user))
		lumniClose(@isa,contactIsa)
	end

	def update
		@isa = Isa.lumniStart(params,current_company, list: current_user.template('Isa','isas',current_user))
		contactIsa = @isa.lumniSave(params,current_user, list: current_user.template('Isa','isas',current_user))
		lumniClose(@isa,contactIsa)
	end
	def destroy
		@isa = Isa.lumniStart(params,current_company, list: current_user.template('Isa','isas',current_user))
		contactIsa = @isa.lumniSave(params,current_user, list: current_user.template('Isa','isas',current_user))
		lumniClose(@cluster,contactIsa)
	end

	def set_isa_status
		@isa = Isa.cached_find(params[:id])
		if @isa.send("stored_#{params[:status_case]}") != params[:status]
			@isa.set_new_status(params[:status_case],params[:status], params[:start_date], params[:end_date])
			@isa.update_isa_status
		end
		@isa = Isa.cached_find(params[:id])
	end

	def disable_status
		@isa = Isa.cached_find(params[:id])
		if @isa.send("stored_#{params[:status_case]}") == params[:status]
			@isa.current_status(params[:status_case]).update(phase: 'deactivated')
		end
		@isa = Isa.cached_find(params[:id])
	end

	def activate_disbursement_cancellation_application
		@isa = Isa.find(params[:id])
		@cancellation_request = @isa.cancellation_request
		if @cancellation_request.nil?
			if @isa.cancellation_request.nil?
				@cancellation_request = CancellationRequest.create({isa_id: @isa.id, status: 'active'})
			end
		end

		@application = @isa.cancellation_application

		if @application.nil?
			@application = Application.create!({ status: "active", 
					user_id: @isa.user_id, 
					funding_opportunity_id: @isa.funding_opportunity_id, 
					step: 1,
					application_case: "cancellation_request", 
					resource_type: "CancellationRequest", 
					resource_id: @cancellation_request.id
					})
		end

		redirect_to edit_application_path(@application)
	end

	def activate_conciliation_application

		@isa = Isa.find(params[:id])
		@conciliation = @isa.conciliation_information.find_or_create_by(year: params[:conciliation][:year],income_information_id: params[:conciliation][:income_information_id])
		@application = @conciliation.application

		if @application.nil?
			@application = Application.create!({ status: "active", 
					user_id: @isa.user_id, 
					funding_opportunity_id: @isa.funding_opportunity_id, 
					step: 1,
					application_case: "conciliation", 
					resource_type: "ConciliationInformation", 
					resource_id: @conciliation.id
					})
		end

		redirect_to edit_application_path(@application)
	end








end