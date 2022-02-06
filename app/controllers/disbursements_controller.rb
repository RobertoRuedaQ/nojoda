class DisbursementsController < ApplicationController
	def index
		@disbursement = Disbursement.lumniStart(params,current_company, list: current_user.template('Disbursement','disbursements',current_user))
		contactDisbursement = @disbursement.lumniSave(params,current_user, list: current_user.template('Disbursement','disbursements',current_user))
		lumniClose(@disbursement,contactDisbursement)
	end

	def new
		@disbursement = Disbursement.lumniStart(params,current_company, list: current_user.template('Disbursement','disbursements',current_user))
		contactDisbursement = @disbursement.lumniSave(params,current_user, list: current_user.template('Disbursement','disbursements',current_user))
		lumniClose(@disbursement,contactDisbursement)
	end

	def create
		@disbursement = Disbursement.lumniStart(params,current_company, list: current_user.template('Disbursement','disbursements',current_user))
		contactDisbursement = @disbursement.lumniSave(params,current_user, list: current_user.template('Disbursement','disbursements',current_user))
		lumniClose(@disbursement,contactDisbursement)
	end

	def edit
		@disbursement = Disbursement.lumniStart(params,current_company, list: current_user.template('Disbursement','disbursements',current_user))
		contactDisbursement = @disbursement.lumniSave(params,current_user, list: current_user.template('Disbursement','disbursements',current_user))
		lumniClose(@disbursement,contactDisbursement)
	end

	def update
		@disbursement = Disbursement.lumniStart(params,current_company, list: current_user.template('Disbursement','disbursements',current_user))
		contactDisbursement = @disbursement.lumniSave(params,current_user, list: current_user.template('Disbursement','disbursements',current_user))
		lumniClose(@disbursement,contactDisbursement)
	end
	def destroy
		@disbursement = Disbursement.lumniStart(params,current_company, list: current_user.template('Disbursement','disbursements',current_user))
		contactDisbursement = @disbursement.lumniSave(params,current_user, list: current_user.template('Disbursement','disbursements',current_user))
		lumniClose(@cluster,contactDisbursement)
	end

	def activate
		@disbursement = Disbursement.cached_find(params[:id])
		@disbursement.update(status: 'active')
		redirect_to edit_student_path(@disbursement.funding_option.right_application.user)
	end
	def deactivate
		@disbursement = Disbursement.cached_find(params[:id])
		@disbursement.update(status: 'active')
		redirect_to edit_student_path(@disbursement.funding_option.right_application.user)
	end

	def activate_disbursement_cancellation_application
		@disbursement = Disbursement.find(params[:id])
		@cancellation_request = @disbursement.cancellation_request
		if @cancellation_request.nil?
			if @disbursement.cancellation_request.nil?
				@cancellation_request = CancellationRequest.create({disbursement_id: @disbursement.id, status: 'active'})
			end
		end

		@application = @disbursement.cancellation_application

		if @application.nil?
			@application = Application.create!({ status: "active", 
					user_id: @disbursement.user.id, 
					funding_opportunity_id: @disbursement.funding_opportunity.id, 
					step: 1,
					application_case: "cancellation_request", 
					resource_type: "CancellationRequest", 
					resource_id: @cancellation_request.id
					})
		end

		redirect_to edit_application_path(@application)
	end

	def force_disbursement_payment
		# @isa = Isa.find(params[:id])
		# @disbursement = Disbursement.create({})


	end



end