class PaymentsController < ApplicationController
	def index
		@payment = Payment.lumniStart(params,current_company, list: current_user.template('Payment','payments',current_user)).paginate(page: params[:page], per_page: 25)
		contactPayment = @payment.lumniSave(params,current_user, list: current_user.template('Payment','payments',current_user))
		lumniClose(@payment,contactPayment)
	end

	def new
		@payment = Payment.lumniStart(params,current_company, list: current_user.template('Payment','payments',current_user))
		contactPayment = @payment.lumniSave(params,current_user, list: current_user.template('Payment','payments',current_user))
		lumniClose(@payment,contactPayment)
	end

	def create
		@payment = Payment.lumniStart(params,current_company, list: current_user.template('Payment','payments',current_user))
		contactPayment = @payment.lumniSave(params,current_user, list: current_user.template('Payment','payments',current_user))
		lumniClose(@payment,contactPayment)
	end

	def edit
		@payment = Payment.lumniStart(params,current_company, list: current_user.template('Payment','payments',current_user))
		contactPayment = @payment.lumniSave(params,current_user, list: current_user.template('Payment','payments',current_user))
		lumniClose(@payment,contactPayment)
	end

	def update
		@payment = Payment.lumniStart(params,current_company, list: current_user.template('Payment','payments',current_user))
		contactPayment = @payment.lumniSave(params,current_user, list: current_user.template('Payment','payments',current_user))
		lumniClose(@payment,contactPayment)
	end
	def destroy
		@payment = Payment.lumniStart(params,current_company, list: current_user.template('Payment','payments',current_user))
		contactPayment = @payment.lumniSave(params,current_user, list: current_user.template('Payment','payments',current_user))
		lumniClose(@cluster,contactPayment)
	end

	def manual_payment_application
		billing_document = BillingDocument.cached_find(params[:id])
		payment = Payment.find_by(billing_document_id: params[:id],status: 'under_review')
		if payment.nil?
			payment = Payment.create({billing_document_id: params[:id],status: 'under_review'})
		end

		application = payment.application.find_by(status: 'active')
		if application.nil?
			application = Application.new({status: 'active',user_id: current_user.id,application_case: 'manual_payment',resource_type: 'Payment', resource_id: payment.id})
		end

		if application.save
			redirect_to edit_application_path(application)
		else
			redirect_to root_path
		end

	end

	def send_manual_payment_application
	end
end